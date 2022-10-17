//
//  ContentView.swift
//  WorkingTime
//
//  Created by lcr on 2022/10/10.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WorkTime.timestamp, ascending: true)],
        animation: .default)

    private var items: FetchedResults<WorkTime>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                    } label: {
                        //                        Text(item.timestamp!, formatter: itemFormatter)
                        if let title = item.title {
                            Text(title)
                        } else {
                            Text("タイトル未設定")
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        // すでにあるかサーチ
        if checkAlreadyCreated(date: Date()) {
            print("既に作成されている")
            return
        }
        let startDate = Date()
        withAnimation {
            let title = titleFormatter.string(from: startDate)
            let newItem = WorkTime(context: viewContext)
            newItem.title = title
            newItem.timestamp = startDate
            newItem.startedAt = startDate
            newItem.endedAt = startDate

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

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
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

    private func checkAlreadyCreated(date: Date) -> Bool {
        // TODO: @FetchRequet化
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        let dateFrom = calendar.startOfDay(for: date)
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
        let predicate = NSPredicate(format : "startedAt <= %@ AND  startedAt >= %@", dateTo! as CVarArg, dateFrom as CVarArg)
        let request = NSFetchRequest<WorkTime>(entityName: "WorkTime")
        request.sortDescriptors = []
        request.predicate = predicate
        do {
            let result = try viewContext.fetch(request)
            print("結果",result)
            return !result.isEmpty

        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

private let titleFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    formatter.locale = Locale(identifier: "ja_JP")
    return formatter
}()

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
