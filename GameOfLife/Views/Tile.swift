//
//  Tile.swift
//  GameOfLife
//
//  Created by Finnis on 01/06/2021.
//

import SwiftUI

struct Tile: View {
    @EnvironmentObject var gameManager: GameManager
    
    var position: (Int, Int)
    
    var colour: Color {
        if gameManager.board[position.0][position.1] == true {
            return Color.white
        } else {
            return Color.black
        }
    }
    
    var body: some View {
        Color(.black)
            .frame(width: 20, height: 20)
    }
}
