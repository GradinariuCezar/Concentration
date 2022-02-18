//
//  ViewController.swift
//  Concentration
//
//  Created by Cezar Nicolae Gradinariu on 17.02.2022.
//

import UIKit

class ViewController: UIViewController {

    var flipCount: Int = 0{
        didSet{
            flipCountLabel.text="Flips: \(flipCount)"

        }
    }

    override func viewDidLoad() {
        print("App started")

    }

    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!

    var emojiChoices = ["🎃","👻" ,"🎃" ,"👻"]

    @IBAction func touchCard(_ sender: UIButton){
        flipCount+=1
        if let cardNumber=cardButtons.index(of: sender){
            print ("cardNumber=\(cardNumber)")
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        }
        else{
            print("chosen card was not in cardButtons")
        }
    }
    func flipCard(withEmoji emoji:String, on button:UIButton){
        print("flipcard (withemoji:\(emoji))")
        if button.currentTitle == emoji{
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = UIColor.orange

        }
        else{
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = UIColor.white
        }
    }

}

