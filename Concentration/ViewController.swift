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
    override func viewDidLoad() {
        print("App started")
    }

    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    @IBAction func touchCard(_ sender: UIButton){
        if let cardNumber = cardButtons.index(of: sender){
            scoreUpdate(at: cardNumber)
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)



            }
        }
    }
    var selectedCards = [Int:Int]()
    func scoreUpdate(at index: Int){
        if selectedCards[game.cards[index].identifier] == nil{
            selectedCards[game.cards[index].identifier]=1
        }
        else{
            selectedCards[game.cards[index].identifier]! += 1

            //daca avem o carte deja intoarsa
            if let indexFlippedCard = game.indexOfOneAndOnlyFaceUpCard{
                if game.cards[indexFlippedCard].identifier == game.cards[index].identifier{
                    score += 2
                }
                else
                {
                    if selectedCards[game.cards[index].identifier]! > 1 {
                        score -= 1
                    }
                    if selectedCards[game.cards[indexFlippedCard].identifier]! > 1 {
                        score -= 1
                    }
                }
            }
        }


    }

    var emoji = [Int:String]()
    var emojiChoices = [["🎃", "👻", "🦇", "😱", "🍭","🍎","🙀"],
                        ["😀","😂","🙃","😍","😎","🥳"],
                        ["🏀","⚽️","🏈","⚾️","🥎","🏐"],
                        ["🐈","🐶","🐹","🦊","🐷","🐒"],
                        ["👶","👧","👩‍🦳","👮‍♀️","🧑‍🌾","👩‍🍳"],
                        ["☀️","🌘","⛈","💦","🌊","☃️"]]
    lazy var theme = game.themes[Int(arc4random_uniform(UInt32(game.themes.count)))]
    lazy var themeNo = Int(arc4random_uniform(UInt32(game.themes.count)))
    func emoji_f(for card:Card) -> String{
        //print("dictionar:" + emoji[card.identifier]!)
        print(emoji.count)
        if emoji[card.identifier] == nil,theme.emojis.count > 0 {
            let randomIndex=Int(arc4random_uniform(UInt32(emojiChoices[themeNo].count)))
            emoji[card.identifier]=emojiChoices[Int(themeNo)].remove(at: randomIndex)

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
        //print(themeNo)
        for index in cardButtons.indices{
            cardButtons[index].setTitle("", for: UIControl.State.normal)
            cardButtons[index].backgroundColor = UIColor.orange
            game.resetCards()
            emoji.removeAll()
            selectedCards.removeAll()
        }
        flipCount=game.flipCount
    }
}

