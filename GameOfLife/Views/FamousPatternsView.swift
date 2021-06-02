//
//  FamousPatternsView.swift
//  GameOfLife
//
//  Created by Finnis on 02/06/2021.
//

import SwiftUI

struct FamousPatternsView: View {
    @EnvironmentObject var gameManager: GameManager
    @Binding var showFamousPatternsSheet: Bool
    
    var body: some View {
        NavigationView {
            List {
                ForEach(gameManager.patternTypes.keys.sorted(), id: \.self) { patternType in
                    Section(header: Text(patternType).textCase(nil)) {
                        ForEach(gameManager.patternTypes[patternType]!) { pattern in
                            Button(action: {
                                gameManager.setBoard(board: pattern.board)
                                showFamousPatternsSheet = false
                            }, label: {
                                Text(pattern.name)
                            })
                        }
                    }
                }
            }
            .navigationTitle("Famous Patterns")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        showFamousPatternsSheet = false
                    }, label: {
                        Text("Cancel")
                    })
                }
            }
        }
    }
}
