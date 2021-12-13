//
//  ReminisceApp.swift
//  Shared
//
//  Created by Teruya Hasegawa on 2021/11/29.
//

import SwiftUI

@main
struct ReminisceApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
