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
        self.isRevealed = true
    }
}

class Board {
    let length = 9
    var cells: [[Cell]]
    let numMines = 10
    
    init() {
        cells = Array(repeating: Array(repeating: Cell(value: 0), count: self.length), count: self.length)
        self.scrambleMines()
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
    
    func scrambleMines() {
        var minesRemaining = self.numMines
        while minesRemaining > 0 {
            let r = Int(arc4random_uniform(UInt32(self.length)))
            let c = Int(arc4random_uniform(UInt32(self.length)))
            if !self.mineAt(row: r, col: c) {
                self.setMineAt(row: r, col: c)
                minesRemaining -= 1
            }
        }
    }
    
    func mineAt(row: Int, col: Int) -> Bool {
        return self.numberAt(row: row, col: col) == -1
    }
    
    func setMineAt(row: Int, col: Int) {
        self.cells[row][col].value = -1
    }
}
