//
//  Pattern.swift
//  GameOfLife
//
//  Created by Finnis on 02/06/2021.
//

import Foundation

struct Pattern: Hashable, Codable, Identifiable {
    var name: String
    var id: Int
    var type: String
    var board: [[Bool]]
}
