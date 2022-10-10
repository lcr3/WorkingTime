//
//  WorkTime+CoreDataProperties.swift
//  WorkingTime
//
//  Created by lcr on 2022/10/10.
//
//

import Foundation
import CoreData


extension WorkTime {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkTime> {
        return NSFetchRequest<WorkTime>(entityName: "WorkTime")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var startedAt: Date?
    @NSManaged public var endedAt: Date?
    @NSManaged public var title: String?

}

extension WorkTime : Identifiable {

}
