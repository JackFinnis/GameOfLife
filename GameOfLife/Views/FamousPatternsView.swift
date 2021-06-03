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
    
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar(searchText: $searchText)
                List {
                    ForEach(gameManager.famousPatternTypes.keys.sorted(), id: \.self) { famousPatternType in
                        Section(header: Text(famousPatternType).textCase(nil)) {
                            ForEach(gameManager.famousPatternTypes[famousPatternType]!.filter {
                                self.searchText.isEmpty ? true : ($0.name.contains(self.searchText))
                            }) { famousPattern in
                                Button(action: {
                                    gameManager.setBoard(board: famousPattern.board)
                                    showFamousPatternsSheet = false
                                }, label: {
                                    Text(famousPattern.name)
                                })
                            }
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
