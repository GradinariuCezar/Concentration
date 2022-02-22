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
    var score: Int = 0{
        didSet{
            scoreLabel.text="Score: \(score)"
        }
    }

    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    var emoji = [Int:String]()
    lazy var theme = game.themes[Int(arc4random_uniform(UInt32(game.themes.count)))]
    lazy var themeNo = Int(arc4random_uniform(UInt32(game.themes.count)))

    override func viewDidLoad() {
        for index in cardButtons.indices{
            cardButtons[index].backgroundColor = theme.color
        }
        scoreLabel.textColor = theme.color
        flipCountLabel.textColor = theme.color
        newGameButton.setTitleColor(theme.color, for: UIControl.State.normal)
    }

    @IBAction func touchCard(_ sender: UIButton){
        if let cardNumber = cardButtons.index(of: sender){
            score = game.scoreUpdate(at: cardNumber)
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            flipCount=game.flipCount
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 0) : theme.color
            }
        }
    }

    func emoji_f(for card:Card) -> String{
        if emoji[card.identifier] == nil,theme.emojis.count > 0 {
            let randomIndex=Int(arc4random_uniform(UInt32(theme.emojis.count)))
            emoji[card.identifier] = theme.emojis.remove(at: randomIndex)

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
        theme = game.themes[Int(arc4random_uniform(UInt32(game.themes.count)))]
        for index in cardButtons.indices{
            cardButtons[index].setTitle("", for: UIControl.State.normal)
            cardButtons[index].backgroundColor = theme.color
            game.resetCards()
            emoji.removeAll()
        }
        scoreLabel.textColor = theme.color
        flipCountLabel.textColor = theme.color
        score = game.score
        flipCount = game.flipCount
        newGameButton.setTitleColor(theme.color, for: UIControl.State.normal)
    }
}

