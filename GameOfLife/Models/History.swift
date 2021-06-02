//
//  LinkedList.swift
//  GameOfLife
//
//  Created by Finnis on 02/06/2021.
//

import Foundation

class Day {
    var board: [[Bool]]
    var yesterday: Day?
    var tomorrow: Day?
    
    init(board: [[Bool]], yesterday: Day?, tomorrow: Day?) {
        self.board = board
        self.yesterday = yesterday
        self.tomorrow = tomorrow
    }
}
