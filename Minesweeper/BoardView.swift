//
//  BoardView.swift
//  Minesweeper
//
//  Created by Lindberg on 4/22/18.
//  Copyright © 2018 Lindberg. All rights reserved.
//

import UIKit

func fontSizeFor(_ string: NSString, fontName: String, targetSize: CGSize) -> CGFloat {
    let testFontSize: CGFloat = 32
    let font = UIFont(name: fontName, size: testFontSize)
    let attr = [NSAttributedStringKey.font: font!]
    let strSize = string.size(withAttributes: attr)
    
    return testFontSize*min(targetSize.width/strSize.width, targetSize.height/strSize.height)
}

class BoardView: UIView {
    override func draw(_ rect: CGRect) {
        // Code referenced and adapted from SudokuView.swift in Project 2: Sudoku
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.board
        
        let context = UIGraphicsGetCurrentContext()
        
        let gridSize = (self.bounds.width < self.bounds.height) ? self.bounds.width : self.bounds.height
        let gridOrigin = CGPoint(x: (self.bounds.width - gridSize)/2, y: (self.bounds.height - gridSize)/2)
        let delta = gridSize/3
        let d = delta/3
        
        context?.setLineWidth(3)
        UIColor.black.setStroke()
        context?.stroke(CGRect(x: gridOrigin.x, y: gridOrigin.y, width: gridSize, height: gridSize))
        
        for i in 0 ..< board!.length {
            for j in 0 ..< board!.length {
                let x = gridOrigin.x + CGFloat(i)*delta + CGFloat(j)*d
                context?.move(to: CGPoint(x: x, y: gridOrigin.y))
                context?.addLine(to: CGPoint(x: x, y: gridOrigin.y + gridSize))
                let y = gridOrigin.y + CGFloat(i)*delta + CGFloat(j)*d
                context?.move(to: CGPoint(x: gridOrigin.x, y: y))
                context?.addLine(to: CGPoint(x: gridOrigin.x + gridSize, y: y))
                context?.strokePath()
            }
        }
        
        let fontName = "Helvetica-Bold"
        let fontSize = fontSizeFor("0", fontName: fontName, targetSize: CGSize(width: d, height: d))
        let font = UIFont(name: fontName, size: fontSize)
        let attributes = [NSAttributedStringKey.font: font!, NSAttributedStringKey.foregroundColor: UIColor.blue]
        
        for row in 0 ..< board!.length {
            for col in 0 ..< board!.length {
                let number = board!.cells[row][col]
                let text = "\(number)" as NSString
                let textSize = text.size(withAttributes: attributes)
                let x = gridOrigin.x + CGFloat(col)*d + 0.5*(d - textSize.width)
                let y = gridOrigin.y + CGFloat(row)*d + 0.5*(d - textSize.height)
                let textRect = CGRect(x: x, y: y, width: textSize.width, height: textSize.height)
                text.draw(in: textRect, withAttributes: attributes)
            }
        }
    }
}
