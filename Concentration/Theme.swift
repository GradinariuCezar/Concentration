//
//  Theme.swift
//  Concentration
//
//  Created by Cezar Nicolae Gradinariu on 22.02.2022.
//

import Foundation
import UIKit

struct Theme{
    var name: String
    var color: UIColor
    var emojis: [String]

    init(name:String, color:UIColor,emojis: [String]){
        self.name = name
        self.color = color
        self.emojis = emojis
    }
}
