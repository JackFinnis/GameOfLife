//
//  SaveNewPatternView.swift
//  GameOfLife
//
//  Created by Finnis on 02/06/2021.
//

import SwiftUI

struct SaveNewPatternView: View {
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
    @Binding var showSaveNewPatternSheet: Bool
    
    @State var patternName: String = ""
    @State var patternType: String = ""
    @State var showErrorMessageAlert: Bool = false
    @State var errorMessage: String = ""
    @State var showTypePickerPopover: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Pattern")) {
                    TextField("Name", text: $patternName)
                    HStack(spacing: 0) {
                        TextField("Tag", text: $patternType)
                        Picker("", selection: $patternType) {
                            ForEach(savedPatternTypes.keys.sorted(), id: \.self) { type in
                                Button(action: {
                                    patternType = type
                                }, label: {
                                    Text(type)
                                })
                            }
                        }
                    }
                }
                .disableAutocorrection(true)
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
                            errorMessage = "Please enter the pattern's name"
                            showErrorMessageAlert = true
                        } else if patternType == "" {
                            errorMessage = "Please enter the pattern's tag"
                            showErrorMessageAlert = true
                        } else {
                            let newPattern = CDPattern(context: managedObjectContext)
                            newPattern.name = patternName
                            newPattern.type = patternType
                            newPattern.board = gameManager.today.board
                            PersistenceController.shared.saveContext()
                            showSaveNewPatternSheet = false
                        }
                    }, label: {
                        Text("Save")
                    })
                }
            }
            .alert(isPresented: $showErrorMessageAlert) {
                Alert(
                    title: Text(errorMessage),
                    dismissButton: .default(Text("Dismiss"))
                )
            }
        }
    }
}
