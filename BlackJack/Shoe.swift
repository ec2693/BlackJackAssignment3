//
//  shoe.swift
//  BlackJackExtension
//
//  Created by Era Chaudhary on 3/3/15.
//  Copyright (c) 2015 Era Chaudhary. All rights reserved.
//

import Foundation

class Shoe{
    
    var Shoe:[Int] = []
    
   // var singleton = Singleton.getObject
    
    func createShoe(var numberOfDecksInShoe: Int){
        var suits=["Clubs","Hearts","Spades","Diamonds"]
        var cards=[1,2,3,4,5,6,7,8,9,10,10,10,10]
        
        for i in 1...numberOfDecksInShoe{
            for suit in suits{
                for card in cards{
                    Shoe.append(card)
                    
                }
            }
        }
        
        
        shuffle()
        Singleton.getObject.globalDeck = Shoe
        
    }
    
    func getCardFromShoe() -> Int {
        return Singleton.getObject.globalDeck.removeAtIndex(0)
      
    }

    
    func shuffle() {
        var temp: Int
        for i in 0...(Shoe.count-1) {
            let j = Int(arc4random_uniform(UnicodeScalarValue(Shoe.count)))
            println(j)
            temp = Shoe[i]
            println(i,j)
            Shoe[i]=Shoe[j]
            Shoe[j]=temp
            
        }
        
    }
    
    
    
}