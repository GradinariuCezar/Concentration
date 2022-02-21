//
//  Card.swift
//  Concentration
//
//  Created by Cezar Nicolae Gradinariu on 18.02.2022.
//

import Foundation


struct Card{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    static var identifierFactory = 0
    static func getUniqueIdentifier() -> Int{
        identifierFactory+=1
        return identifierFactory
    }
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
