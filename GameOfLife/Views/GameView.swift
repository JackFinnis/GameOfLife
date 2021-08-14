//
//  GameView.swift
//  GameOfLife
//
//  Created by Finnis on 01/06/2021.
//

import SwiftUI

struct GameView: View {
    @StateObject var gameManager = GameManager()
    @State var scale: CGFloat = 0.9
    
    var body: some View {
        ZStack {
            Color(.systemFill)
                .ignoresSafeArea()
            Board(scale: $scale)
                .ignoresSafeArea()
            FloatingButtons(scale: $scale)
        }
        .environmentObject(gameManager)
    }
}

