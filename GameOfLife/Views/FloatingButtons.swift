//
//  FloatingButtons.swift
//  GameOfLife
//
//  Created by Finnis on 01/06/2021.
//

import SwiftUI

struct FloatingButtons: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var gameManager: GameManager
    @Binding var scale: CGFloat
    
    @State var showFamousPatternsSheet: Bool = false
    @State var showSavedPatternsSheet: Bool = false
    @State var showSaveNewPatternSheet: Bool = false
    @State var showClearBoardHistoryAlert: Bool = false
    @State var longPressingNext: Bool = false
    @State var longPressingPrevious: Bool = false
    
    var autoplayImage: String {
        if gameManager.playing {
            return "stop.fill"
        } else {
            return "play.fill"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(spacing: 0) {
                // Autoplay speed slider
                HStack(spacing: 0) {
                    Slider(value: $gameManager.speed, in: 0.1...0.9, step: 0.2, onEditingChanged: { data in
                        if gameManager.playing {
                            gameManager.startAutoplay()
                        }
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
                
                // Display famous patterns
                Button(action: {
                    showFamousPatternsSheet = true
                }, label: {
                    Image(systemName: "safari")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                .sheet(isPresented: $showFamousPatternsSheet) {
                    FamousPatternsView(showFamousPatternsSheet: $showFamousPatternsSheet)
                        .environment(\.managedObjectContext, self.managedObjectContext)
                        .environmentObject(gameManager)
                }
                
                // Paste saved day
                Button(action: {
                    showSavedPatternsSheet = true
                }, label: {
                    Image(systemName: "folder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                .sheet(isPresented: $showSavedPatternsSheet) {
                    SavedPatternsView(showSavedPatternsSheet: $showSavedPatternsSheet)
                        .environment(\.managedObjectContext, self.managedObjectContext)
                        .environmentObject(gameManager)
                }
                
                // Copy today
                Button(action: {
                    showSaveNewPatternSheet = true
                }, label: {
                    Image(systemName: "square.and.arrow.down")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                .sheet(isPresented: $showSaveNewPatternSheet) {
                    SaveNewPatternView(showSaveNewPatternSheet: $showSaveNewPatternSheet)
                        .environment(\.managedObjectContext, self.managedObjectContext)
                        .environmentObject(gameManager)
                }
                
                // Toggle autoplay
                Button(action: {
                    if gameManager.playing {
                        gameManager.stopAutoplay()
                    } else {
                        gameManager.startAutoplay()
                    }
                }, label: {
                    Image(systemName: autoplayImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                
                // Show previous day
                Button(action: {
                    if longPressingPrevious {
                        longPressingPrevious = false
                        gameManager.stopAutoplay()
                    } else {
                        gameManager.previousDay()
                    }
                }, label: {
                    Image(systemName: "arrowshape.turn.up.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                .simultaneousGesture(
                    LongPressGesture()
                        .onEnded { gesture in
                            longPressingPrevious = true
                            gameManager.startAutoPrevious()
                        }
                )
                
                // Show next day
                Button(action: {
                    if longPressingNext {
                        longPressingNext = false
                        gameManager.stopAutoplay()
                    } else {
                        gameManager.nextDay()
                    }
                }, label: {
                    Image(systemName: "arrowshape.turn.up.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                .simultaneousGesture(
                    LongPressGesture()
                        .onEnded { gesture in
                            longPressingNext = true
                            gameManager.startAutoNext()
                        }
                )
                
                // Reset board
                Button(action: {
                    gameManager.resetBoard()
                }, label: {
                    Image(systemName: "clear")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                .contextMenu {
                    Button(action: {
                        gameManager.resetBoard()
                    }, label: {
                        Label("Reset Board", systemImage: "clear")
                    })
                    Button(action: {
                        gameManager.resetBoardClearHistory()
                    }, label: {
                        Label("Clear History", systemImage: "trash")
                    })
                }
                
                // Zoom level slider
                HStack(spacing: 0) {
                    Text("Zoom")
                        .padding(.leading, 20)
                        .padding(.vertical, 10)
                    Slider(value: $scale, in: 0.3...0.9)
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

