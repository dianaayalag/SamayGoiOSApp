//
//  SamayGoApp.swift
//  SamayGo
//
//  Created by Diana Ayala Galvan on 6/07/26.
//

import SwiftUI
import CoreData

@main
struct SamayGoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
