//
//  ViewController.swift
//  TicTacToe-Practice
//
//  Created by Borchert, Otto on 2/22/20.
//  Copyright © 2020 Borchert, Otto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var upperLeft: UIImageView!
    @IBOutlet var upperMiddle: UIImageView!
    @IBOutlet var upperRight: UIImageView!
    @IBOutlet var centerLeft: UIImageView!
    @IBOutlet var centerMiddle: UIImageView!
    @IBOutlet var centerRight: UIImageView!
    @IBOutlet var bottomLeft: UIImageView!
    @IBOutlet var bottomMiddle: UIImageView!
    @IBOutlet var bottomRight: UIImageView!

    var images: [[UIImageView]]? = nil

    //TODO: Create a model instance variable
    let model = TicTacToeBoard()
    var secondsRemaining = 10
    var timer = Timer()
    
    //TODO (in the View): Make sure all of the board images are blank.png

    //TODO (in the View, and link here in the Controller): Create a new label for "status text" Ex: Whose turn it is, whether someone won, and whether there was an invalid move
    
    @IBOutlet weak var statusMessage: UILabel!
    @IBAction func buttonClicked(_ sender: UIButton) {
        //Step 1 - Get the row number and column number from the button text (See hint in assignment instructions)
        secondsRemaining = 10
        timer.invalidate()
        statusMessage.text = "\(model.turn)'s Turn!"
        let boardString = sender.currentTitle!
                
                let index = 0
                let charAt = boardString.index(boardString.startIndex, offsetBy: index)
                let charAt2 = boardString.index(boardString.startIndex, offsetBy: 2)
                
                let row = boardString[charAt].wholeNumberValue!
                let col = boardString[charAt2].wholeNumberValue!

        
        //Step 2 - Place the marker in the *model*
        
        if model.placeMarker(row:row, column:col) == true {
                if model.turn == "X"{
                    images![row][col].image = UIImage(named: "X.png")
                    print(row)
                }
                else if model.turn == "O"{
                    images![row][col].image = UIImage(named: "O.png")
                }
        
        var didWin = model.didWin()
            
        if didWin == " "{
            model.nextTurn()
            statusMessage.text = "\(model.turn)'s turn"
            
        }
        else if didWin == "T" {
            statusMessage.text = "Tie Game!"
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(restartTimer), userInfo: nil, repeats: true)
        }
        else if didWin == "X" {
            statusMessage.text = "X Wins!"
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(restartTimer), userInfo: nil, repeats: true)
        }
        else if didWin == "O" {
            statusMessage.text = "O Wins!"
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(restartTimer), userInfo: nil, repeats: true)
        }
        }
    }
    
    @objc func restartTimer() {
        if secondsRemaining > 0 {
            statusMessage.text = "New game in \(secondsRemaining)"
            secondsRemaining -= 1
        }
        else {
            var rowIndex = 0
            var index = 0
            for boardRow in images!{
                index = 0
                for boardCol in boardRow{
                    images![rowIndex][index].image = UIImage(named: "blank.png")
                    index += 1
                }
                rowIndex += 1
            }
            
            model.reset()
            statusMessage.text = "New game: It's \(model.turn)'s Turn"
        }
    }
        //If placing was successful....
           //Step 3 - Get the turn from the *model* and place the appropriate image in the spot in the images array
        
           //Step 4 - Check for a winner, updating the status message and creating a countdown timer to reset the game if necessary
           // Check the EggTimer assignment on Udemy for hints on creating the countdown timer
           // Make sure you reset the images to blank.png
        
           //Step 5 - If no one won, make the *model* go to the next turn, get the current turn from the model and update the status message.
        
        //If placing the marker wasn't successful, change the status message, so the user knows what's wrong
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusMessage.text = "Let's play! It's \(model.turn)'s turn"

        // This loads the image array so it matches the model
        images = [[upperLeft, upperMiddle, upperRight],
                  [centerLeft, centerMiddle, centerRight],
                  [bottomLeft, bottomMiddle, bottomRight]]

    }


}
