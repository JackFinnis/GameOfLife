//
//  FloatingButtons.swift
//  GameOfLife
//
//  Created by Finnis on 01/06/2021.
//

import SwiftUI

struct FloatingButtons: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            if gameManager.playing {
                HStack {
                    Text("Slow")
                    Slider(value: $gameManager.speed, in: 0.1...0.9, step: 0.2)
                    Text("Fast")
                }
                .padding()
                .background(Color(UIColor.systemBackground))
                .clipShape(Capsule())
                .compositingGroup()
                .shadow(radius: 2, y: 2)
                .padding(.horizontal, 20)
            }
            
            HStack(spacing: 0) {
                Button(action: {
                    gameManager.cancellable?.cancel()
                    gameManager.playing = false
                    gameManager.board = [[Bool]](repeating: [Bool](repeating: false, count: gameManager.size), count: gameManager.size)
                }, label: {
                    Label("Clear", systemImage: "clear")
                })
                .padding()
                .foregroundColor(.accentColor)
                .background(Color(UIColor.systemBackground))
                .clipShape(Capsule())
                .compositingGroup()
                .shadow(radius: 2, y: 2)
                .padding(.horizontal, 10)
                
                Button(action: {
                    updateGameAutoplay()
                    gameManager.playing.toggle()
                }, label: {
                    Image(systemName: gameManager.autoplayImage)
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .clipShape(Circle())
                        .compositingGroup()
                        .shadow(radius: 2, y: 2)
                        .padding(.horizontal, 10)
                })
                
                Button(action: {
                    gameManager.cancellable?.cancel()
                    gameManager.playing = false
                    gameManager.nextDay()
                }, label: {
                    Label("Next", systemImage: "arrowshape.turn.up.right")
                })
                .padding()
                .foregroundColor(.accentColor)
                .background(Color(UIColor.systemBackground))
                .clipShape(Capsule())
                .compositingGroup()
                .shadow(radius: 2, y: 2)
                .padding(.horizontal, 10)
            }
            .padding()
        }
        .animation(.default)
    }
    
    func updateGameAutoplay() {
        if gameManager.playing {
            gameManager.cancellable?.cancel()
        } else {
            gameManager.startAutoplay()
        }
    }
}

