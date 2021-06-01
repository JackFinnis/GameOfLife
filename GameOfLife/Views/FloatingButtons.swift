//
//  FloatingButtons.swift
//  GameOfLife
//
//  Created by Finnis on 01/06/2021.
//

import SwiftUI

struct FloatingButtons: View {
    @EnvironmentObject var gameManager: GameManager
    
    @State var playing: Bool = false
    var autoplayImage: String {
        if playing {
            return "stop.fill"
        } else {
            return "play.fill"
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 0) {
                Button(action: {
                    gameManager.cancellable?.cancel()
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
                    playing.toggle()
                }, label: {
                    Image(systemName: autoplayImage)
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
    }
    
    func updateGameAutoplay() {
        if playing {
            gameManager.cancellable?.cancel()
        } else {
            gameManager.startAutoplay()
        }
    }
}

