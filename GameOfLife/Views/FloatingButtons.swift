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
                    Slider(value: $gameManager.speed, in: 1...5, step: 1, onEditingChanged: { data in
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
                .clipShape(Capsule())
                .compositingGroup()
                .shadow(color: Color(UIColor.systemFill), radius: 5)
                .padding(.trailing, 15)
                
                // Display famous patterns
                Button(action: {
                    showFamousPatternsSheet = true
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 25))
                        .frame(width: 60, height: 60)
                        .background(Color(UIColor.systemBackground))
                        .clipShape(Circle())
                        .compositingGroup()
                        .shadow(color: Color(UIColor.systemFill), radius: 5)
                        .padding(.horizontal, 5)
                })
                .sheet(isPresented: $showFamousPatternsSheet) {
                    FamousPatternsView(showFamousPatternsSheet: $showFamousPatternsSheet)
                        .environment(\.managedObjectContext, self.managedObjectContext)
                        .environmentObject(gameManager)
                        .animation(.default)
                }
                
                // Paste saved day
                Button(action: {
                    showSavedPatternsSheet = true
                }, label: {
                    Image(systemName: "folder")
                        .font(.system(size: 25))
                        .frame(width: 60, height: 60)
                        .background(Color(UIColor.systemBackground))
                        .clipShape(Circle())
                        .compositingGroup()
                        .shadow(color: Color(UIColor.systemFill), radius: 5)
                        .padding(.horizontal, 5)
                })
                .sheet(isPresented: $showSavedPatternsSheet.animation()) {
                    SavedPatternsView(showSavedPatternsSheet: $showSavedPatternsSheet, showSaveNewPatternSheet: $showSaveNewPatternSheet)
                        .environment(\.managedObjectContext, self.managedObjectContext)
                        .environmentObject(gameManager)
                        .animation(.default)
                }
                
                // Copy today
                Button(action: {
                    showSaveNewPatternSheet = true
                }, label: {
                    Image(systemName: "square.and.arrow.down")
                        .font(.system(size: 25))
                        .frame(width: 60, height: 60)
                        .background(Color(UIColor.systemBackground))
                        .clipShape(Circle())
                        .compositingGroup()
                        .shadow(color: Color(UIColor.systemFill), radius: 5)
                        .padding(.horizontal, 5)
                })
                .sheet(isPresented: $showSaveNewPatternSheet.animation()) {
                    SaveNewPatternView(showSaveNewPatternSheet: $showSaveNewPatternSheet)
                        .environment(\.managedObjectContext, self.managedObjectContext)
                        .environmentObject(gameManager)
                        .animation(.default)
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
                        .font(.system(size: 30))
                        .frame(width: 60, height: 60)
                        .background(Color(UIColor.systemBackground))
                        .clipShape(Circle())
                        .compositingGroup()
                        .shadow(color: Color(UIColor.systemFill), radius: 5)
                        .padding(.horizontal, 5)
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
                        .font(.system(size: 25))
                        .frame(width: 60, height: 60)
                        .background(Color(UIColor.systemBackground))
                        .clipShape(Circle())
                        .compositingGroup()
                        .shadow(color: Color(UIColor.systemFill), radius: 5)
                        .padding(.horizontal, 5)
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
                        .font(.system(size: 25))
                        .frame(width: 60, height: 60)
                        .background(Color(UIColor.systemBackground))
                        .clipShape(Circle())
                        .compositingGroup()
                        .shadow(color: Color(UIColor.systemFill), radius: 5)
                        .padding(.horizontal, 5)
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
                        .font(.system(size: 25))
                        .frame(width: 60, height: 60)
                        .background(Color(UIColor.systemBackground))
                        .clipShape(Circle())
                        .compositingGroup()
                        .shadow(color: Color(UIColor.systemFill), radius: 5)
                        .padding(.horizontal, 5)
                })
                
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
                .clipShape(Capsule())
                .compositingGroup()
                .shadow(color: Color(UIColor.systemFill), radius: 5)
                .padding(.leading, 15)
            }
            .padding()
        }
    }
}

