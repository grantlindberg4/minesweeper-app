//
//  ViewController.swift
//  Minesweeper
//
//  Created by Lindberg on 4/22/18.
//  Copyright © 2018 Lindberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var movesLabel: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func newGameButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Game", message: "Would you like to start a new game?", preferredStyle: .alert)
        let newGameAction = UIAlertAction(title: "New Game", style: .default) { (action) in
            let board = self.appDelegate.board
            board!.startNewGame()
            self.updateMoves(moves: 0)
            self.boardView.setNeedsDisplay()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(newGameAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showGameOverAlert() {
        let alert = UIAlertController(title: "Game over", message: "You stepped on a mine!", preferredStyle: .alert)
        let newGameAction = UIAlertAction(title: "New Game", style: .default) { (action) in
            let board = self.appDelegate.board
            board!.startNewGame()
            self.updateMoves(moves: 0)
            self.boardView.setNeedsDisplay()
        }
        alert.addAction(newGameAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showGameWonAlert() {
        let alert = UIAlertController(title: "Congratulations!", message: "You have beaten the game!", preferredStyle: .alert)
        let newGameAction = UIAlertAction(title: "New Game", style: .default) { (action) in
            let board = self.appDelegate.board
            board!.startNewGame()
            self.updateMoves(moves: 0)
            self.boardView.setNeedsDisplay()
        }
        alert.addAction(newGameAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateMoves(moves: Int) {
        self.movesLabel.text = "Moves: \(moves)"
        self.movesLabel.sizeToFit()
    }
}

