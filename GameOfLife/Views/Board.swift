//
//  Board.swift
//  GameOfLife
//
//  Created by Finnis on 01/06/2021.
//

import SwiftUI

struct Board: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        ScrollView([.horizontal, .vertical], showsIndicators: false) {
            HStack(spacing: 1) {
                ForEach(0...gameManager.size-1, id: \.self) { x in
                    VStack(spacing: 1) {
                        ForEach(0...gameManager.size-1, id: \.self) { y in
                            Tile(x: x, y: y)
                        }
                    }
                }
            }
        }
    }
}
