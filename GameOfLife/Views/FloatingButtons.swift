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
    
    @State var showFamousPatternsSheet: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(spacing: 0) {
                // Autoplay speed slider
                HStack(spacing: 0) {
                    Slider(value: $gameManager.speed, in: 0.1...0.9, step: 0.2, onEditingChanged: { data in
                        gameManager.startAutoplay()
                    })
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                    Text("Speed")
                        .padding(.trailing, 20)
                        .padding(.vertical, 10)
                }
                .background(Color(UIColor.systemBackground))
                .cornerRadius(.greatestFiniteMagnitude)
                .compositingGroup()
                .shadow(radius: 2, y: 2)
                .padding(.trailing, 15)
                
                // Reset board
                Button(action: {
                    gameManager.resetGame()
                }, label: {
                    Image(systemName: "clear")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                
                // Paste saved day
                Button(action: {
                    gameManager.loadSavedDay()
                }, label: {
                    Image(systemName: "doc.on.clipboard")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                
                // Copy today
                Button(action: {
                    gameManager.saveToday()
                }, label: {
                    Image(systemName: "doc.on.doc")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                
                // Toggle autoplay
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
                
                // Show previous day
                Button(action: {
                    gameManager.previousDay()
                }, label: {
                    Image(systemName: "arrowshape.turn.up.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                
                // Show next day
                Button(action: {
                    gameManager.nextDay()
                }, label: {
                    Image(systemName: "arrowshape.turn.up.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                
                // Display famous patterns
                Button(action: {
                    showFamousPatternsSheet = true
                }, label: {
                    Image(systemName: "safari")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }).sheet(isPresented: $showFamousPatternsSheet) {
                    FamousPatternsView(showFamousPatternsSheet: $showFamousPatternsSheet)
                }
                
                // Zoom level slider
                HStack(spacing: 0) {
                    Text("Zoom")
                        .padding(.leading, 20)
                        .padding(.vertical, 10)
                    Slider(value: $scale, in: 0.3...1)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                }
                .background(Color(UIColor.systemBackground))
                .cornerRadius(.greatestFiniteMagnitude)
                .compositingGroup()
                .shadow(radius: 2, y: 2)
                .padding(.leading, 15)
            }
            .buttonStyle(SimpleButtonStyle())
            .padding()
        }
    }
}

