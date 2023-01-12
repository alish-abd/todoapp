//
//  NewStopwatchViewCell.swift
//  ToDoApp
//
//  Created by Alisher Abdulin on 12.01.2023.
//

import Foundation
import UIKit
import Combine

class NewStopwatchViewCell: UITableViewCell {

    private var models = [ActivityItem]()
    //MARK: - proporties
    
    // ViewModel to handle the stopwatch logic
    var stopwatchViewModel = NewStopwatchViewModel(activityName: "New Timer") //instead of observable object in swfitUI

    // Cancelable to stop observing the elapsed time
    var cancellable: AnyCancellable?
    
    
    
    let name = "Stopwatch new name"
    static let identifier = "NewStopwatchViewController"


    public let stopwatchLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .medium)
        return label
    }()
    
    public let namelabel: UITextField = {
        let label = UITextField()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.text = ""
//        label.isEnabled = togg
        return label
    }()

    private let startStopButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play"), for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 25
        return button
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 25
        return button
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 25
        return button
    }()




    //MARK: - view lifecycle
    
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(stopwatchLabel)
        contentView.addSubview(namelabel)
        contentView.addSubview(startStopButton)
        contentView.addSubview(resetButton)
        contentView.addSubview(settingsButton)
        
        
        startStopButton.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)


        cancellable = stopwatchViewModel.$elapsedTime.sink { elapsedTime in
            // Update the label with the formatted time
            self.stopwatchLabel.text = self.stopwatchViewModel.formattedElapsedTime()
//            self.namelabel.text = self.stopwatchViewModel.timerName

        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stopwatchLabel.frame = CGRect(x: 20, y: Int(contentView.safeAreaInsets.top), width: Int(200), height: 30)
        startStopButton.frame = CGRect(x: contentView.right - 60, y: contentView.safeAreaInsets.top, width: 50, height: 50)
        resetButton.frame = CGRect(x: contentView.right - 120, y: contentView.safeAreaInsets.top, width: 50, height: 50)
        settingsButton.frame = CGRect(x: contentView.right - 180, y: contentView.safeAreaInsets.top, width: 50, height: 50)
        namelabel.frame = CGRect(x: 20, y: stopwatchLabel.bottom, width: 200, height: 20)
        
    }
    

    @objc func resetButtonTapped() {
        stopwatchViewModel.reset()
    }

    @objc func startStopButtonTapped() {
        stopwatchViewModel.isRunning.toggle()

            //update the button image

        if stopwatchViewModel.isRunning{
            startStopButton.setImage(UIImage(systemName: "pause"), for: .normal)
        } else {
            startStopButton.setImage(UIImage(systemName: "play"), for: .normal)
        }
    }

    //MARK: - Actions

}
