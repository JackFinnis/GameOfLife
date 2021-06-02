//
//  SavedPatternsView.swift
//  GameOfLife
//
//  Created by Finnis on 02/06/2021.
//

import SwiftUI

struct SavedPatternsView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: SavedPattern.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \SavedPattern.name, ascending: true)
        ]
    ) var savedPatterns: FetchedResults<SavedPattern>
    
    @EnvironmentObject var gameManager: GameManager
    @Binding var showSavedPatternsSheet: Bool
    
    @State var searchText: String = ""
    @State var patternName: String = ""
    @State var showErrorMessage: Bool = false
    
    var filteredSavedPatterns: [SavedPattern] {
        self.savedPatterns.filter {
            self.searchText.isEmpty ? true : ($0.name!.contains(self.searchText))
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar(searchText: $searchText)
                List {
                    ForEach(filteredSavedPatterns, id: \.self) { (pattern: SavedPattern) in
                        Button(action: {
                            gameManager.setBoard(board: pattern.board!)
                            showSavedPatternsSheet = false
                        }, label: {
                            Text(pattern.name!)
                        })
                    }
                    .onDelete(perform: { indexSet in
                        for index in indexSet {
                            managedObjectContext.delete(savedPatterns[index])
                        }
                        PersistenceController.shared.saveContext()
                    })
                }
            }
            .navigationTitle("My Patterns")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        showSavedPatternsSheet = false
                    }, label: {
                        Text("Cancel")
                    })
                }
                ToolbarItem(placement: .automatic) {
                    EditButton()
                }
            }
        }
    }
}
