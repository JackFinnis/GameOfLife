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
        VStack {
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
                    gameManager.toggleAutoplaySpeed()
                }, label: {
                    Image(systemName: gameManager.autoplaySpeed.rawValue)
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
            .padding()
            .buttonStyle(SimpleButtonStyle())
        }
    }
}

