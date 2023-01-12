////
////  HomeViewController.swift
////  ToDoApp
////
////  Created by Alisher Abdulin on 12.01.2023.
////
//
//import Foundation
//import UIKit
//import Combine
//
//class StopwatchesView: ObservableObject {
//    @Published var timers = [NewStopwatchViewModel] ()
//    
//    init() {
//        self.timers.append(NewStopwatchViewModel(timerName: "New Timer"))
//        
//
//    }
//    
//    func add() {
//        print("new Timer added")
//        self.timers.append(NewStopwatchViewModel(timerName: "New Timer"))
//    }
//
//
//    
//}
//
//class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.register(NewStopwatchViewCell.self,
//                           forCellReuseIdentifier: NewStopwatchViewCell.identifier)
//        return tableView
//    }()
//    
//    var stopwatches = StopwatchesView() {
//        didSet {
//            tableView.reloadData()
//        }
//    }
//    
//    private var timers = [TimerListItem]()
//    
//    var cancellable: AnyCancellable?
//    
//    
//    
//    private let addButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .systemBlue
//        button.tintColor = .white
//        button.setImage(UIImage(systemName: "plus",
//                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium)), for: .normal)
//        button.layer.cornerRadius = 35
//        button.layer.borderWidth = 2
//        //        button.layer.borderColor = CGColor(
//        return button
//    }()
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(tableView)
//        view.addSubview(addButton)
//        
//        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//        
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tableView.frame = view.bounds
//        addButton.frame = CGRect(x: view.width - 80,
//                                 y: view.height - 80 - view.safeAreaInsets.bottom,
//                                 width: 70,
//                                 height: 70)
//        
//    }
//    
//    
//    @objc func didTapAddButton() {
//        stopwatches.add()
//        tableView.beginUpdates()
//        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right)
//        tableView.endUpdates()
//        print("There are \(stopwatches.timers.count)")
//    }
//    
//    private func handleSettings() {
//        //        let vc = StopwatchSettingsViewController()
//        //
//        //        vc.title = "Stopwatch name"
//        //        let navVC = UINavigationController(rootViewController: vc)
//        //        navVC.navigationItem.largeTitleDisplayMode = .always
//        //        present(navVC, animated: true)
//        
//    }
//    
//    
//    
//    
//    //MARK: - Table
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return stopwatches.timers.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: NewStopwatchViewCell.identifier, for: indexPath)
//        //        let timer = stopwatches.timers[indexPath.row]
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let item = stopwatches.timers[indexPath.row]
//        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
//        
//        sheet.addAction(UIAlertAction(title: "Submit", style: .cancel))
//        
//        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
//            let alert = UIAlertController(title: "Edit activity", message: "Edit activity name", preferredStyle: .alert)
//           
//            alert.addTextField(configurationHandler: nil)
//            alert.textFields?.first?.text = item.name
//            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self] _ in
//                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
//                    return
//                }
//                self?.updateItem(item: item, newName: newName)
//                
//                
//            }))
//            self.present(alert, animated: true)
//        }))
//        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
//            self?.deleteItem(item: item)
//        }))
//        
//        present(sheet, animated: true)
//        
//    }
//    
//    
//    
//}
