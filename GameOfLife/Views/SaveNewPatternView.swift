//
//  SaveNewPatternView.swift
//  GameOfLife
//
//  Created by Finnis on 02/06/2021.
//

import SwiftUI

struct SaveNewPatternView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @EnvironmentObject var gameManager: GameManager
    @Binding var showSaveNewPatternSheet: Bool
    
    @State var patternName: String = ""
    @State var showErrorMessage: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Pattern Name", text: $patternName)
                if showErrorMessage {
                    Text("Please enter a pattern name")
                        .font(.subheadline)
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("New Pattern")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        showSaveNewPatternSheet = false
                    }, label: {
                        Text("Cancel")
                    })
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        if patternName == "" {
                            showErrorMessage = true
                        } else {
                            showErrorMessage = false
                            let newPattern = SavedPattern(context: managedObjectContext)
                            newPattern.name = patternName
                            newPattern.board = gameManager.today.board
                            showSaveNewPatternSheet = false
                            PersistenceController.shared.saveContext()
                        }
                    }, label: {
                        Text("Save")
                    })
                }
            }
        }
    }
}
