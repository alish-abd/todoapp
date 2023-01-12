//
//  File.swift
//  ToDoApp
//
//  Created by Alisher Abdulin on 12.01.2023.
//

import Foundation
import Combine

class NewStopwatchViewModel: ObservableObject, Identifiable {
    
    let activityName: String
    
    init(activityName: String) {
        self.activityName = activityName
    }

    
    private var startTime: Date?
    private var accumulatedTime:TimeInterval = 0
    private var timer: Cancellable?
    
    @Published var isRunning = false {
        didSet {
            if self.isRunning {
                self.start()
            } else {
                self.stop()
            }
        }
    }
    
    @Published private(set) var elapsedTime: TimeInterval = 0
    
    private func start() -> Void {
        self.startTime = Date()
        self.timer?.cancel()
        self.timer = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.elapsedTime = self.getElapsedTime()
            }
    }
    
    private func stop() -> Void {
        self.timer?.cancel()
        self.timer = nil
        self.accumulatedTime = self.getElapsedTime()
        self.startTime = nil
    }
    
    func reset() -> Void {
        self.accumulatedTime = 0
        self.elapsedTime = 0
        self.startTime = nil
        self.isRunning = false
    }
    
    private func getElapsedTime() -> TimeInterval {
        return -(self.startTime?.timeIntervalSinceNow ?? 0)+self.accumulatedTime
    }
    
    
    func formattedElapsedTime() -> String {
        // Format the elapsed time as a stopwatch time
        let hours = Int(elapsedTime) / 3600
        let minutes = Int(elapsedTime) / 60 % 60
        let seconds = Int(elapsedTime) % 60
        let milliseconds = Int(elapsedTime * 100) % 100
        
        // Return the formatted time
        return String(format: "%02d:%02d:%02d:%02d", hours, minutes, seconds, milliseconds)
    }
}

