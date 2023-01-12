//
//  ActivityViewController.swift
//  ToDoApp
//
//  Created by Alisher Abdulin on 12.01.2023.
//

import UIKit

class ActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(NewStopwatchViewCell.self,
                                   forCellReuseIdentifier: NewStopwatchViewCell.identifier)
        
        return table
    }()
    
    private var models = [TimerItem]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Activities"
        view.addSubview(tableView)
        getAllItem()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    @objc func didTapAdd() {
        let alert = UIAlertController(title: "New activity", message: "Enter name of activity", preferredStyle: .alert)
        present(alert, animated: true)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            self?.createItem(name: text)
        }))
        
    }
    
    
    //MARK: -Table setting
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = model.name
//
//        return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: NewStopwatchViewCell.identifier, for: indexPath) as! NewStopwatchViewCell
        
//        cell.configure(with: .init(activityName: model.name))
        
        cell.namelabel.text = model.timerName
        cell.stopwatchLabel.text = stopwatchViewModel.formattedElapsedTime()
        return cell
    }
    var stopwatchViewModel = NewStopwatchViewModel(activityName: "New Timer") //instead of observable
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]
        let sheet = UIAlertController(title: "Edit activity settings", message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Submit", style: .cancel))
        
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            let alert = UIAlertController(title: "Edit Item", message: "Edit your item", preferredStyle: .alert)
           
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.timerName
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
                    return
                }
                self?.updateItem(item: item, newName: newName)
                
                
            }))
            self.present(alert, animated: true)
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
        
        present(sheet, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    

    
    
    //MARK: -Coredata
    func getAllItem() {
        do {
            models = try context.fetch(TimerItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }
        catch {
            // error
        }
        
    }
    
    func createItem(name:String) {
        let newItem = TimerItem(context: context)
        newItem.timerName = name
        newItem.startTime = Date()
        newItem.accumulatedTime = TimeInterval()
        
        do {
            try context.save()
            getAllItem()
        }
        catch {
            //error
        }
    }
    
    func deleteItem(item: TimerItem) {
        context.delete(item)
        do {
            try context.save()
            getAllItem()
        }
        catch {
            //error
        }
    }
    
    func updateItem(item: TimerItem, newName: String) {
        item.timerName = newName
        
        do {
            try context.save()
            getAllItem()
        }
        catch {
            //error
        }
    }

}
