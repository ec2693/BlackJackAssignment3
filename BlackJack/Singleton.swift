//
//  Singleton.swift
//  BlackJackExtension
//
//  Created by Era Chaudhary on 3/2/15.
//  Copyright (c) 2015 Era Chaudhary. All rights reserved.
//

import Foundation
class Singleton {
    
    var numberOfPlayers:Int = 0
    
    var numberOfDecks:Int = 0
    
    var initialBalance:Double = 0
    
    var globalDeck:[Int] = []
    
     class var getObject: Singleton {
        struct Static {
            static let instance: Singleton = Singleton()
        }
        return Static.instance
    }
}

