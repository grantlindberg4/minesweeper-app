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

func tapOccurredInBounds(row: Int, col: Int, length: Int) -> Bool {
    return 0 <= col && col < length && 0 <= row && row < length
}

func drawGridLines(length: Int, gridSize: CGFloat, gridOrigin: CGPoint, delta: CGFloat, d: CGFloat) {
    let context = UIGraphicsGetCurrentContext()
    context?.setLineWidth(3)
    UIColor.black.setStroke()
    context?.stroke(CGRect(x: gridOrigin.x, y: gridOrigin.y, width: gridSize, height: gridSize))
    
    for i in 0 ..< length {
        for j in 0 ..< length {
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

func drawCells(board: Board?, gridOrigin: CGPoint, d: CGFloat) {
    let fontName = "Helvetica-Bold"
    let fontSize = fontSizeFor("0", fontName: fontName, targetSize: CGSize(width: d, height: d))
    let font = UIFont(name: fontName, size: fontSize)
    
    let fixedAttributes = [
        1: [NSAttributedStringKey.font: font!, NSAttributedStringKey.foregroundColor: UIColor.red],
        2: [NSAttributedStringKey.font: font!, NSAttributedStringKey.foregroundColor: UIColor.orange],
        3: [NSAttributedStringKey.font: font!, NSAttributedStringKey.foregroundColor: UIColor.yellow],
        4: [NSAttributedStringKey.font: font!, NSAttributedStringKey.foregroundColor: UIColor.green],
        5: [NSAttributedStringKey.font: font!, NSAttributedStringKey.foregroundColor: UIColor.blue],
        6: [NSAttributedStringKey.font: font!, NSAttributedStringKey.foregroundColor: UIColor.purple],
        7: [NSAttributedStringKey.font: font!, NSAttributedStringKey.foregroundColor: UIColor.brown],
        8: [NSAttributedStringKey.font: font!, NSAttributedStringKey.foregroundColor: UIColor.black],
    ]
    
    for row in 0 ..< board!.length {
        for col in 0 ..< board!.length {
            if !board!.isRevealedAt(row: row, col: col) {
                continue
            }
            
            let text: NSString
            var attributes : [NSAttributedStringKey : NSObject]? = nil
            if board!.mineAt(row: row, col: col) {
                text = "💥" as NSString
                let textSize = text.size(withAttributes: attributes)
                let x = gridOrigin.x + CGFloat(col)*d + 0.5*(d - textSize.width)
                let y = gridOrigin.y + CGFloat(row)*d + 0.5*(d - textSize.height)
                let textRect = CGRect(x: x, y: y, width: textSize.width, height: textSize.height)
                text.draw(in: textRect, withAttributes: attributes)
            }
            else {
                let number = board!.numberAt(row: row, col: col)
                if number == 0 {
                    let x = gridOrigin.x + CGFloat(col)*d
                    let y = gridOrigin.y + CGFloat(row)*d
                    let rect = CGRect(
                        origin: CGPoint(x: x, y: y),
                        size: CGSize(width: 280/board!.length, height: 280/board!.length)
                    )
                    UIColor.darkGray.set()
                    UIRectFill(rect)
                }
                else {
                    attributes = fixedAttributes[number]
                    text = "\(number)" as NSString
                    let textSize = text.size(withAttributes: attributes)
                    let x = gridOrigin.x + CGFloat(col)*d + 0.5*(d - textSize.width)
                    let y = gridOrigin.y + CGFloat(row)*d + 0.5*(d - textSize.height)
                    let textRect = CGRect(x: x, y: y, width: textSize.width, height: textSize.height)
                    text.draw(in: textRect, withAttributes: attributes)
                }
            }
        }
    }
}

class BoardView: UIView {
    @IBAction func handleTap(_ sender: UIGestureRecognizer) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.board
        
        let tapPoint = sender.location(in: self)
        let gridSize = (self.bounds.width < self.bounds.height) ? self.bounds.width : self.bounds.height
        let gridOrigin = CGPoint(x: (self.bounds.width - gridSize)/2, y: (self.bounds.height - gridSize)/2)
        let d = gridSize/CGFloat(board!.length)
        let col = Int((tapPoint.x - gridOrigin.x)/d)
        let row = Int((tapPoint.y - gridOrigin.y)/d)
        
        if tapOccurredInBounds(row: row, col: col, length: board!.length) {
            if board!.firstTap {
                board!.generateBoardFrom(row: row, col: col)
                board!.firstTap = false
            }
            if board!.mineAt(row: row, col: col) {
                let viewController = appDelegate.window!.rootViewController as? ViewController
                viewController?.showGameOverAlert()
            }
            else {
                board!.revealCellsAround(row: row, col: col)
                if board!.wonGame() {
                    let viewController = appDelegate.window!.rootViewController as? ViewController
                    viewController?.showGameWonAlert()
                }
            }
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        // Code referenced and adapted from SudokuView.swift in Project 2: Sudoku
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.board
        
        let gridSize = (self.bounds.width < self.bounds.height) ? self.bounds.width : self.bounds.height
        let gridOrigin = CGPoint(x: (self.bounds.width - gridSize)/2, y: (self.bounds.height - gridSize)/2)
        let delta = gridSize/CGFloat(board!.length).squareRoot()
        let d = delta/CGFloat(board!.length).squareRoot()
        
        drawGridLines(length: board!.length, gridSize: gridSize, gridOrigin: gridOrigin, delta: delta, d: d)
        drawCells(board: board, gridOrigin: gridOrigin, d: d)
    }
}
