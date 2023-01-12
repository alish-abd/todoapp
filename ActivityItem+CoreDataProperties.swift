//
//  ActivityItem+CoreDataProperties.swift
//  ToDoApp
//
//  Created by Alisher Abdulin on 12.01.2023.
//
//

import Foundation
import CoreData


extension ActivityItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActivityItem> {
        return NSFetchRequest<ActivityItem>(entityName: "ActivityItem")
    }

    @NSManaged public var startTime: Date?
    @NSManaged public var name: String?
    @NSManaged public var accumulatedTime: Double

}

extension ActivityItem : Identifiable {

}
