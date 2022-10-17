//
//  File.swift
//  WorkingTime
//
//  Created by lcr on 2022/10/10.
//

import CoreData
import Combine
import Foundation
import SwiftUI

public class CoreDataStore {
    @Environment(\.managedObjectContext) private var viewContext

//    public func checkAlreadyCreated(date: Date) -> Bool {
////        let datePredicate = NSPredicate(format: "%K == %@", #keyPath(WorkTime.startedAt), date)
//        let predicate = NSPredicate(format: "startedAt >= %@", date as CVarArg)
//        let request = FetchRequest<WorkTime>(entity: WorkTime.entity(), sortDescriptors: [], predicate: predicate)
//        do {
//            let result = try viewContext.fetch(request)
//            print(result)
//
//            return true
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            return false
//        }
//    }

    // :TODO エラー処理
    public func add(title: String, startedAd: Date) {
        let newItem = WorkTime(context: viewContext)
        newItem.title = title
        newItem.timestamp = startedAd
        newItem.startedAt = startedAd
        newItem.endedAt = startedAd

        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    public func delete(objects: [WorkTime]) {
        objects.forEach(viewContext.delete)
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }

    }
}
