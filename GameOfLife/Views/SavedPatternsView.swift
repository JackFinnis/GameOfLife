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
        entity: CDPattern.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \CDPattern.name, ascending: true)
        ]
    ) var savedPatterns: FetchedResults<CDPattern>
    var savedPatternTypes: [String: [CDPattern]] {
        Dictionary(grouping: savedPatterns, by: { $0.type! })
    }
    
    @EnvironmentObject var gameManager: GameManager
    @Binding var showSavedPatternsSheet: Bool
    @Binding var showSaveNewPatternSheet: Bool
    
    @State var searchText: String = ""
    @State var patternName: String = ""
    @State var showErrorMessage: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    SearchBar(searchText: $searchText)
                    List {
                        ForEach(savedPatternTypes.keys.sorted(), id: \.self) { savedPatternType in
                            Section(header: Text(savedPatternType).textCase(nil)) {
                                ForEach(savedPatternTypes[savedPatternType]!.filter {
                                    self.searchText.isEmpty ? true : ($0.name!.contains(self.searchText))
                                }) { (savedPattern: CDPattern) in
                                    Button(action: {
                                        gameManager.setBoard(board: savedPattern.board!)
                                        showSavedPatternsSheet = false
                                    }, label: {
                                        Text(savedPattern.name!)
                                    })
                                }
                                .onDelete(perform: { indexSet in
                                    for index in indexSet {
                                        let patternToDelete = savedPatternTypes[savedPatternType]![index]
                                        managedObjectContext.delete(patternToDelete)
                                        PersistenceController.shared.saveContext()
                                    }
                                })
                            }
                        }
                    }
                }
                if savedPatternTypes.isEmpty {
                    Button(action: {
                        showSavedPatternsSheet = false
                        showSaveNewPatternSheet = true
                    }, label: {
                        Text("Save pattern")
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
