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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.board
        
        board!.startNewGame()
        boardView.setNeedsDisplay()
    }
}

extension ViewController {
    func showGameOverAlert() {
        let alert = UIAlertController(title: "Game over", message: "You stepped on a mine!", preferredStyle: .alert)
        let newGameAction = UIAlertAction(title: "New Game", style: .default) { (action) in
            self.appDelegate.board?.startNewGame()
            self.boardView.setNeedsDisplay()
        }
        alert.addAction(newGameAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showGameWonAlert() {
        let alert = UIAlertController(title: "Congratulations!", message: "You have beaten the game!", preferredStyle: .alert)
        let newGameAction = UIAlertAction(title: "New Game", style: .default) { (action) in
            self.appDelegate.board?.startNewGame()
            self.boardView.setNeedsDisplay()
        }
        alert.addAction(newGameAction)
        self.present(alert, animated: true, completion: nil)
    }
}

