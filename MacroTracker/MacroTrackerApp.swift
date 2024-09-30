//
//  MacroTrackerApp.swift
//  MacroTracker
//
//  Created by Trevor Clute on 10/15/23.
//

import SwiftUI
import CoreData

@main
struct MacroTrackerApp: App {
    @StateObject var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
