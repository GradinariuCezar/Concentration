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
    var wasSeen = false
    var identifier: Int
    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int{
        identifierFactory+=1
        return identifierFactory
    }
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
