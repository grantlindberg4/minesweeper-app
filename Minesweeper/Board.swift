//
//  Board.swift
//  Minesweeper
//
//  Created by Lindberg on 4/22/18.
//  Copyright © 2018 Lindberg. All rights reserved.
//

import Foundation

class Board {
    let length = 9
    var cells: [[Int]]
    
    init() {
        cells = Array(repeating: Array(repeating: 1, count: self.length), count: self.length)
    }
}
