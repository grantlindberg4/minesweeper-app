//
//  Board.swift
//  Minesweeper
//
//  Created by Lindberg on 4/22/18.
//  Copyright © 2018 Lindberg. All rights reserved.
//

import Foundation

struct Cell {
    var value: Int
    var isRevealed: Bool
    
    init(value: Int) {
        self.value = value
        self.isRevealed = false
    }
}

class Board {
    let length = 9
    var cells: [[Cell]]
    
    init() {
        cells = Array(repeating: Array(repeating: Cell(value: 1), count: self.length), count: self.length)
    }
    
    func numberAt(row: Int, col: Int) -> Int {
        return self.cells[row][col].value
    }
    
    func isRevealedAt(row: Int, col: Int) -> Bool {
        return self.cells[row][col].isRevealed
    }
    
    func revealCellAt(row: Int, col: Int) {
        self.cells[row][col].isRevealed = true
    }
}
