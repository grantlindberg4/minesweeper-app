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
    let length: Int
    var cells: [[Cell]]
    let numMines = 10
    var firstTap: Bool
    
    init(length: Int) {
        self.length = length
        self.cells = [[]]
        self.firstTap = true
    }
    
    func startNewGame() {
        cells = Array(repeating: Array(repeating: Cell(value: 0), count: self.length), count: self.length)
        self.firstTap = true
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
    
    func scrambleMines(row: Int, col: Int) {
        var unavailable: [(Int, Int)] = []
        for r in row-1 ..< row+2 {
            if r < 0 || r > 9 {
                continue
            }
            for c in col-1 ..< col+2 {
                if c < 0 || c > 9 {
                    continue
                }
                unavailable.append((r, c))
            }
        }
//        print("\(unavailable)")
        
        var minesRemaining = self.numMines
        while minesRemaining > 0 {
            let r = Int(arc4random_uniform(UInt32(self.length)))
            let c = Int(arc4random_uniform(UInt32(self.length)))
            if !self.mineAt(row: r, col: c) && !unavailable.contains(where: {$0 == (r, c)}) {
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
