//
//  GameOfLifeApp.swift
//  GameOfLife
//
//  Created by Finnis on 01/06/2021.
//

import SwiftUI

@main
struct GameOfLifeApp: App {
    
    // Game of life manager
    @StateObject var gameManager = GameManager()
    
    var body: some Scene {
        WindowGroup {
            Board()
                .environmentObject(gameManager)
        }
    }
}
