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
    
//    static var baseUrl = "http://10.77.194.34"
    static var baseUrl = "http://192.168.18.114" // IP del ESP32-CAM
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .tint(Color(hex: "#624B8B"))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
