//
//  BoardView.swift
//  Minesweeper
//
//  Created by Lindberg on 4/22/18.
//  Copyright © 2018 Lindberg. All rights reserved.
//

import UIKit

let BOARD_LENGTH: Int = 3
let DELTA_LENGTH: CGFloat = 3

class BoardView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func draw(_ rect: CGRect) {
        // Code referenced and adapted from SudokuView.swift in Project 2: Sudoku
        let context = UIGraphicsGetCurrentContext()
        
        let gridSize = (self.bounds.width < self.bounds.height) ? self.bounds.width : self.bounds.height
        let gridOrigin = CGPoint(x: (self.bounds.width - gridSize)/2, y: (self.bounds.height - gridSize)/2)
        let delta = gridSize/DELTA_LENGTH
        let d = delta/DELTA_LENGTH
        
        context?.setLineWidth(3)
        UIColor.black.setStroke()
        context?.stroke(CGRect(x: gridOrigin.x, y: gridOrigin.y, width: gridSize, height: gridSize))
        
        for i in 0 ..< BOARD_LENGTH {
            for j in 0 ..< BOARD_LENGTH {
                let x = gridOrigin.x + CGFloat(i)*delta + CGFloat(j)*d
                context?.move(to: CGPoint(x: x, y: gridOrigin.y))
                context?.addLine(to: CGPoint(x: x, y: gridOrigin.y + gridSize))
                let y = gridOrigin.y + CGFloat(i)*delta + CGFloat(j)*d
                context?.move(to: CGPoint(x: gridOrigin.x, y: y))
                context?.addLine(to: CGPoint(x: gridOrigin.x + gridSize, y: y))
                context?.strokePath()
            }
        }
    }

}
