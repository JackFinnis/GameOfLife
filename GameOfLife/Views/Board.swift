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
        Tile(position: (0, 0))
    }
}
