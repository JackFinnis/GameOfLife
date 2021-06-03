//
//  Day.swift
//  GameOfLife
//
//  Created by Finnis on 02/06/2021.
//

import Foundation

class Day {
    var board: [[Bool]]
    var yesterday: Day?
    
    init(board: [[Bool]], yesterday: Day?) {
        self.board = board
        self.yesterday = yesterday
    }
}
