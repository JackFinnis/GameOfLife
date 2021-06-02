//
//  GameView.swift
//  GameOfLife
//
//  Created by Finnis on 01/06/2021.
//

import SwiftUI

struct GameView: View {
    // Board Sizes:
    //  - 25 for iPhone
    //  - 50 for iPad
    @StateObject var gameManager = GameManager(size: 50)
    @State var scale: CGFloat = 0.9
    
    var body: some View {
        ZStack {
            Color(.systemFill)
                .ignoresSafeArea()
            Board(scale: $scale)
                .ignoresSafeArea()
            FloatingButtons(scale: $scale)
        }
        .statusBar(hidden: true)
        .environmentObject(gameManager)
    }
}

