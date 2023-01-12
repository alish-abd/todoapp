//
//  TimerItem+CoreDataProperties.swift
//  ToDoApp
//
//  Created by Alisher Abdulin on 12.01.2023.
//
//

import Foundation
import CoreData


extension TimerItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimerItem> {
        return NSFetchRequest<TimerItem>(entityName: "TimerItem")
    }

    @NSManaged public var timerName: String?
    @NSManaged public var accumulatedTime: Double
    @NSManaged public var calculatedTime: Double
    @NSManaged public var finalTime: String?
    
    @NSManaged public var startTime: Date?


}

extension TimerItem : Identifiable {

}
