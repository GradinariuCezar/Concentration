//
//  ViewController.swift
//  Concentration
//
//  Created by Cezar Nicolae Gradinariu on 17.02.2022.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)

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



    @IBAction func touchCard(_ sender: UIButton){
        flipCount+=1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else{
            print("chosen card was not in cardButtons")
        }
    }
    func updateViewFromModel(){
        for index in cardButtons.indices{
                let button=cardButtons[index]
            let card=game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji_f(for: card), for: UIControl.State.normal)
                button.backgroundColor = UIColor.white
            }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)



            }
            }
        }
    var emoji = [Int:String]()
    var emojiChoices = ["🎃", "👻", "🦇", "😱", "🍭","🍎","🙀"]
    func emoji_f(for card:Card) -> String{
        //print("dictionar:" + emoji[card.identifier]!)
        print(emoji.count)
        if emoji[card.identifier] == nil,emojiChoices.count > 0 {
            let randomIndex=Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier]=emojiChoices.remove(at: randomIndex)

        }
        return emoji[card.identifier] ?? "?"
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


    @IBAction func pressNewGame(_ sender: Any) {
        flipCount=0
        for index in cardButtons.indices{
            cardButtons[index].setTitle("", for: UIControl.State.normal)
            cardButtons[index].backgroundColor = UIColor.orange
            game.cards[index].isMatched = false
            game.cards[index].isFaceUp = false
        }

    }

}

