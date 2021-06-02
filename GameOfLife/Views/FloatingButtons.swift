//
//  FloatingButtons.swift
//  GameOfLife
//
//  Created by Finnis on 01/06/2021.
//

import SwiftUI

struct FloatingButtons: View {
    @EnvironmentObject var gameManager: GameManager
    
    @Binding var scale: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(spacing: 0) {
                Button(action: {
                    gameManager.resetGame()
                }, label: {
                    Image(systemName: "clear")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                
                Button(action: {
                    if gameManager.playing {
                        gameManager.stopAutoplay()
                    } else {
                        gameManager.startAutoplay()
                    }
                }, label: {
                    Image(systemName: gameManager.autoplayImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                
                Button(action: {
                    gameManager.previousDay()
                }, label: {
                    Image(systemName: "arrowshape.turn.up.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                
                Button(action: {
                    gameManager.nextDay()
                }, label: {
                    Image(systemName: "arrowshape.turn.up.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
            }
            .buttonStyle(SimpleButtonStyle())
            .padding(.horizontal, 15)
            
            HStack(spacing: 0) {
                Slider(value: $gameManager.speed, in: 0.1...0.9, step: 0.2, onEditingChanged: { data in
                    gameManager.startAutoplay()
                })
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.white)
                .cornerRadius(.greatestFiniteMagnitude)
                .compositingGroup()
                .shadow(radius: 2, y: 2)
                .padding(.horizontal, 10)
                
                Slider(value: $scale, in: 0.5...1.5)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .foregroundColor(.accentColor)
                    .background(Color.white)
                    .cornerRadius(.greatestFiniteMagnitude)
                    .compositingGroup()
                    .shadow(radius: 2, y: 2)
                    .padding(.horizontal, 10)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 20)
        }
    }
}

