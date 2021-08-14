//
//  GameManager.swift
//  GameOfLife
//
//  Created by Finnis on 01/06/2021.
//

import Foundation
import Combine
import UIKit

class GameManager: NSObject, ObservableObject {
    // MARK: - Properties
    @Published var size: Int = 50
    @Published var playing: Bool = false
    @Published var speed: Double = 1
    @Published var today = Day(board: [[Bool]](repeating: [Bool](repeating: false, count: 50), count: 50), yesterday: nil)
    @Published var famousPatterns: [Pattern] = GameOfLife.load("FamousPatterns.json")
    @Published var searchText: String = ""

    var formattedSpeed: Double {
        switch speed {
        case 1:
            return 0.9
        case 2:
            return 0.7
        case 3:
            return 0.5
        case 4:
            return 0.3
        default:
            return 0.1
        }
    }
    var cancellable: Cancellable?
    var famousPatternTypes: [String: [Pattern]] {
        Dictionary(grouping: famousPatterns, by: { $0.type })
    }
    
    // MARK: - Private Methods
    // Calculate the next day
    private func next() {
        let countBoard = getCountBoard()
        
        // Update the board
        var newBoard = today.board
        for x in 0..<today.board.count {
            for y in 0..<today.board.count {
                if today.board[x][y] {
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
        
        // Only move on if board is different
        if newBoard != today.board {
            let newDay = Day(board: newBoard, yesterday: today)
            today = newDay
        }
    }
    
    // Return count board (each tile's number of alive neighbours)
    private func getCountBoard() -> [[Int]] {
        var countBoard = [[Int]](repeating: [Int](repeating: 0, count: size), count: size)
        for x in 0..<today.board.count {
            for y in 0..<today.board.count {
                if today.board[x][y] {
                    countBoard = updateCountBoard(countBoard: countBoard, x: x, y: y)
                }
            }
        }
        return countBoard
    }
    
    // Update count board given position of living tile
    private func updateCountBoard(countBoard: [[Int]], x: Int, y: Int) -> [[Int]] {
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
    
    // Return an empty board
    private func getEmptyBoard() -> [[Bool]] {
        [[Bool]](repeating: [Bool](repeating: false, count: size), count: size)
    }
    
    // MARK: - Public Methods
    // Set board
    func setBoard(board: [[Bool]]) {
        stopAutoplay()
        today = Day(board: board, yesterday: today)
    }
    
    // Start autoplay
    func startAutoplay() {
        playing = true
        cancellable = Timer.publish(every: formattedSpeed, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.next()
            }
    }
    
    // Stop autoplay
    func stopAutoplay() {
        playing = false
        cancellable?.cancel()
    }
    
    // Start auto-next
    func startAutoNext() {
        stopAutoplay()
        cancellable = Timer.publish(every: formattedSpeed, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.next()
            }
    }
    
    // Start auto-previous
    func startAutoPrevious() {
        stopAutoplay()
        cancellable = Timer.publish(every: formattedSpeed, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.autoPreviousDay()
            }
    }
    
    // Auto-previous day
    func autoPreviousDay() {
        if today.yesterday != nil {
            today = today.yesterday!
        }
    }
    
    // Go back a day
    func previousDay() {
        stopAutoplay()
        if today.yesterday != nil {
            today = today.yesterday!
        }
    }
    
    // Step one day forward
    func nextDay() {
        stopAutoplay()
        next()
    }
    
    // Reset the board
    func resetBoard() {
        stopAutoplay()
        today = Day(board: getEmptyBoard(), yesterday: today)
    }
}

extension GameManager: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange: String) {
        self.searchText = textDidChange
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchBarshowCancelButton = true
//        showCancelButton = true
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchText = ""
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
