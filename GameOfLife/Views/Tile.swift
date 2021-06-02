//
//  Tile.swift
//  GameOfLife
//
//  Created by Finnis on 01/06/2021.
//

import SwiftUI

struct Tile: View {
    @EnvironmentObject var gameManager: GameManager
    
    var x: Int
    var y: Int
    
    var tileColour: UIColor {
        if gameManager.today.board[x][y] == true {
            return UIColor.white
        } else {
            return UIColor.black
        }
    }
    
    var body: some View {
        Color(tileColour)
            .frame(width: 50, height: 50)
            .onTapGesture {
                gameManager.today.board[x][y].toggle()
                gameManager.objectWillChange.send()
            }
    }
}
