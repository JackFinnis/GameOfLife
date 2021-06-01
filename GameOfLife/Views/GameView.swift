//
//  GameView.swift
//  GameOfLife
//
//  Created by Finnis on 01/06/2021.
//

import SwiftUI

struct GameView: View {
    
    // Game manager
    @StateObject var gameManager = GameManager()
    
    var body: some View {
        ZStack {
            Color(.systemFill)
                .ignoresSafeArea()
            Board()
                .ignoresSafeArea()
            FloatingButtons()
        }
        .statusBar(hidden: true)
        .environmentObject(gameManager)
    }
}

