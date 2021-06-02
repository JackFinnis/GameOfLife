//
//  GameOfLifeApp.swift
//  GameOfLife
//
//  Created by Finnis on 01/06/2021.
//

import SwiftUI

@main
struct GameOfLifeApp: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            GameView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        // Save changes when app moves to background
        .onChange(of: scenePhase) { _ in
            persistenceController.saveContext()
        }
    }
}
