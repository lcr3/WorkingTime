//
//  WorkingTimeApp.swift
//  WorkingTime
//
//  Created by lcr on 2022/10/10.
//

import SwiftUI

@main
struct WorkingTimeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
