//
//  ConcentrationModel.swift
//  Concentration
//
//  Created by Cezar Nicolae Gradinariu on 18.02.2022.
//

import Foundation
import UIKit

class Concentration
{

    var cards = [Card]()
    var flipCount: Int = 0
    var indexOfOneAndOnlyFaceUpCard : Int?
    var score : Int = 0
    var themes: [Theme] = [Theme(name: "Halloween",color: UIColor.orange,emojis: ["🎃", "👻", "🦇", "😱", "🍭","🍎","🙀"]),
                           Theme(name: "Faces",color:  UIColor.yellow,emojis:["😀","😂","🙃","😍","😎","🥳"]),
                           Theme(name: "Sports",color: UIColor.red,emojis:["🏀","⚽️","🏈","⚾️","🥎","🏐"]),Theme(name: "Animals",color: UIColor.blue,emojis: ["🐈","🐶","🐹","🦊","🐷","🐒"]),
                           Theme(name: "People",color:UIColor.brown,emojis:["👶","👧","👩‍🦳","👮‍♀️","🧑‍🌾","👩‍🍳"]),
                           Theme(name: "Weather",color:UIColor.cyan,emojis:["☀️","🌘","⛈","💦","🌊","☃️"]),
                        ]

    func chooseCard(at index:Int){
        if !cards[index].isMatched{
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier{cards[matchIndex].isMatched=true
                    cards[index].isMatched=true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard=nil //two face up cards
            }
            else{
                //either no cards or 2 cards are face up
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp=true
                indexOfOneAndOnlyFaceUpCard=index
            }

        }
    }
    init(numberOfPairsOfCards:Int){
        for _ in 1...numberOfPairsOfCards{
        let card=Card()
        cards+=[card,card]
        }
        cards.shuffle()

        //TODO: Shuffle the cards
}
    func resetCards(){
        flipCount = 0
        for index in cards.indices
        {
            cards[index].isMatched = false
            cards[index].isFaceUp = false
        }
        selectedCards.removeAll()
        score = 0
    }
    var selectedCards = [Int:Int]()
    func scoreUpdate(at index: Int)-> Int{
        if selectedCards[cards[index].identifier] == nil{
            selectedCards[cards[index].identifier]=1
        }
        else{
            selectedCards[cards[index].identifier]! += 1

            //daca avem o carte deja intoarsa
            if let indexFlippedCard = indexOfOneAndOnlyFaceUpCard{
                if cards[indexFlippedCard].identifier == cards[index].identifier{
                    score += 2
                }
                else
                {
                    if selectedCards[cards[index].identifier]! > 1 {
                        score -= 1
                    }
                    if selectedCards[cards[indexFlippedCard].identifier]! > 1 {
                        score -= 1
                    }
                }
            }
        }
        return score
    }


}
