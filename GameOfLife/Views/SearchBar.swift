//
//  SearchBarView.swift
//  Cinema
//
//  Created by Finnis on 20/03/2021.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    
    @State private var isEditing = false
 
    var body: some View {
        HStack(spacing: 0) {
            TextField("Search", text: $searchText)
                .disableAutocorrection(true)
                .padding(8)
                .padding(.horizontal, 26)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack(spacing: 0) {
                        Image(systemName: "magnifyingglass")
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                 
                        if isEditing {
                            Button(action: {
                                self.searchText = ""
                            }, label: {
                                Image(systemName: "multiply.circle.fill")
                                    .padding(.trailing, 8)
                            })
                        }
                    }
                    .foregroundColor(.gray)
                )
                .transition(.move(edge: .trailing))
                .animation(.default, value: isEditing)
                .onTapGesture {
                    isEditing = true
                }
 
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancel")
                        .padding(.leading, 8)
                })
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}
