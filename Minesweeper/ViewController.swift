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
    @IBOutlet weak var timeLabel: UILabel!
    
    var counter = 0
    var timer = Timer()
    
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
            self.timer.invalidate()
            self.resetTimer()
            self.boardView.setNeedsDisplay()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(newGameAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showGameOverAlert() {
        self.timer.invalidate()
        self.updateMoves(moves: 0)

        let alert = UIAlertController(title: "Game over", message: "You stepped on a mine!", preferredStyle: .alert)
        let newGameAction = UIAlertAction(title: "New Game", style: .default) { (action) in
            let board = self.appDelegate.board
            board!.startNewGame()
            self.resetTimer()
            self.boardView.setNeedsDisplay()
        }
        alert.addAction(newGameAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showGameWonAlert() {
        self.timer.invalidate()
        self.updateMoves(moves: 0)

        let alert = UIAlertController(title: "Congratulations!", message: "You have beaten the game!", preferredStyle: .alert)
        let newGameAction = UIAlertAction(title: "New Game", style: .default) { (action) in
            let board = self.appDelegate.board
            board!.startNewGame()
            self.resetTimer()
            self.boardView.setNeedsDisplay()
        }
        alert.addAction(newGameAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateMoves(moves: Int) {
        self.movesLabel.text = "Moves: \(moves)"
        self.movesLabel.sizeToFit()
    }
    
    @objc func updateTime() {
        self.counter += 1
        self.timeLabel.text = "\(self.counter)"
        self.timeLabel.sizeToFit()
    }
    
    func resetTimer() {
        self.timer.invalidate()
        self.counter = 0
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
    }
}

