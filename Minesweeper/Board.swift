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
    
    func generateBoardFrom(row: Int, col: Int) {
        self.scrambleMines(row: row, col: col)
        self.fillRemainingSpaces()
    }
    
    func fillRemainingSpaces() {
        for row in 0 ..< self.length {
            for col in 0 ..< self.length {
                if self.mineAt(row: row, col: col) {
                    continue
                }
                self.cells[row][col].value = self.numMinesAround(row: row, col: col)
            }
        }
    }
    
    func numMinesAround(row: Int, col: Int) -> Int {
        var count = 0
        for r in row-1 ..< row+2 {
            if r < 0 || r >= self.length {
                continue
            }
            for c in col-1 ..< col+2 {
                if c < 0 || c >= self.length {
                    continue
                }
                if mineAt(row: r, col: c) {
                    count += 1
                }
            }
        }
        
        return count
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
    
    func revealCellsAround(row: Int, col: Int) {
        for r in row-1 ..< row+2 {
            if r < 0 || r >= self.length {
                continue
            }
            for c in col-1 ..< col+2 {
                if c < 0 || c >= self.length {
                    continue
                }
                if !self.isRevealedAt(row: r, col: c) && !self.mineAt(row: r, col: c) {
                    self.revealCellAt(row: r, col: c)
                    if self.numMinesAround(row: r, col: c) == 0 {
                        self.revealCellsAround(row: r, col: c)
                    }
                }
            }
        }
    }
    
    func scrambleMines(row: Int, col: Int) {
        var unavailable: [(Int, Int)] = []
        for r in row-1 ..< row+2 {
            if r < 0 || r >= self.length {
                continue
            }
            for c in col-1 ..< col+2 {
                if c < 0 || c >= self.length {
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
    
    func revealAllMines() {
        for r in 0 ..< self.length {
            for c in 0 ..< self.length {
                if self.mineAt(row: r, col: c) {
                    self.revealCellAt(row: r, col: c)
                }
            }
        }
    }
    
    func wonGame() -> Bool {
        for r in 0 ..< self.length {
            for c in 0 ..< self.length {
                if !self.mineAt(row: r, col: c) && !self.isRevealedAt(row: r, col: c) {
                    return false
                }
            }
        }
        
        return true
    }
}
