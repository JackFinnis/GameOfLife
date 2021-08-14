//
//  SearchBarView.swift
//  Cinema
//
//  Created by Finnis on 20/03/2021.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    @EnvironmentObject var gameManager: GameManager
    
    var placeholder = "Search Patterns"

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = gameManager
        searchBar.placeholder = placeholder
        searchBar.backgroundImage = UIImage()
        searchBar.autocorrectionType = .no
        searchBar.showsCancelButton = false
        
        return searchBar
    }

    func updateUIView(_ searchBar: UISearchBar, context: Context) {
        searchBar.text = gameManager.searchText
        searchBar.placeholder = placeholder
    }
}

//
//struct SearchBar: View {
//    @Environment(\.colorScheme) var colorScheme
//    @Binding var searchText: String
//
//    @State private var isEditing = false
//
//    var body: some View {
//        HStack(spacing: 0) {
//            TextField("Search", text: $searchText)
//                .disableAutocorrection(true)
//                .padding(8)
//                .padding(.horizontal, 26)
//                .background(colorScheme == .light ? Color(UIColor.systemGray6) : Color(UIColor.systemGray5))
//                .cornerRadius(8)
//                .overlay(
//                    HStack(spacing: 0) {
//                        Image(systemName: "magnifyingglass")
//                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                            .padding(.leading, 8)
//
//                        if isEditing {
//                            Button(action: {
//                                self.searchText = ""
//                            }, label: {
//                                Image(systemName: "multiply.circle.fill")
//                                    .padding(.trailing, 8)
//                            })
//                        }
//                    }
//                    .foregroundColor(.gray)
//                )
//                .transition(.move(edge: .trailing))
//                .animation(.default, value: isEditing)
//                .onTapGesture {
//                    isEditing = true
//                }
//
//            if isEditing {
//                Button(action: {
//                    self.isEditing = false
//                    self.searchText = ""
//                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                }, label: {
//                    Text("Cancel")
//                        .padding(.leading, 8)
//                })
//                .transition(.move(edge: .trailing))
//                .animation(.default)
//            }
//        }
//        .padding(.horizontal)
//        .padding(.bottom)
//    }
//}
