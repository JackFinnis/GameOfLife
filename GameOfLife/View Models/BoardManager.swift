//
//  BoardManager.swift
//  GameOfLife
//
//  Created by Finnis on 01/06/2021.
//

import Foundation
import Combine

class GameManager: ObservableObject {
    
    @Published var size: Int = 10
    @Published var board = [[Bool]](repeating: [Bool](repeating: false, count: 10), count: 10)
    @Published var speed: Double = 0.5
    @Published var playing: Bool = false
    
    var cancellable: Cancellable?
    var autoplayImage: String {
        if playing {
            return "stop.fill"
        } else {
            return "play.fill"
        }
    }
    
    // Start game of life autoplay
    func startAutoplay() {
        cancellable = Timer.publish(every: speed, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.nextDay()
            }
    }
    
    // Iterate the next day of the game of life
    func nextDay() {
        let countBoard = getCountBoard()
        
        // Update the board
        var newBoard = board
        for x in 0..<board.count {
            for y in 0..<board.count {
                if board[x][y] {
                    // Currently alive
                    if countBoard[x][y] < 2 || countBoard[x][y] > 3 {
                        newBoard[x][y] = false
                    }
                } else {
                    // Currently dead
                    if countBoard[x][y] == 3 {
                        newBoard[x][y] = true
                    }
                }
            }
        }
        DispatchQueue.main.async {
            self.board = newBoard
        }
    }
    
    // Return count board (each tile's number of alive neighbours)
    func getCountBoard() -> [[Int]] {
        var countBoard = [[Int]](repeating: [Int](repeating: 0, count: size), count: size)
        for x in 0..<board.count {
            for y in 0..<board.count {
                if board[x][y] {
                    countBoard = updateCountBoard(countBoard: countBoard, x: x, y: y)
                }
            }
        }
        return countBoard
    }
    
    // Update count board given position of living tile
    func updateCountBoard(countBoard: [[Int]], x: Int, y: Int) -> [[Int]] {
        var newCountBoard = countBoard
        for deltaX in -1...1 {
            let newX = x + deltaX
            // Ensure new index is not out of range
            if newX >= 0 && newX <= size-1 {
                for deltaY in -1...1 {
                    let newY = y + deltaY
                    if newY >= 0 && newY <= size-1 {
                        // Only count surrounding tiles
                        if !(x == newX && y == newY) {
                            newCountBoard[newX][newY] += 1
                        }
                    }
                }
            }
        }
        return newCountBoard
    }
}
