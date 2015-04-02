//
//  Player.swift
//  BlackJackExtension
//
//  Created by Era Chaudhary on 3/3/15.
//  Copyright (c) 2015 Era Chaudhary. All rights reserved.
//

import Foundation


class Player{
    
    var balance : Int
    
    var playerCards : [Int]
    
    var playerStatus : PlayerStatus
    
    var playerBet : Int
    
    init(){
        playerBet = 0
        playerCards = []
        playerStatus = PlayerStatus.Statue
        balance = 100
    }
    
    var playerSum : Int {
        get{
            //Logic to get Ace as 1 or 11 is implemented below .
            var tempSum : Int = 0
            var acePresent:Bool = false
            for card in playerCards {
                if(card == 1){
                    acePresent = true
                }
                tempSum += card
            }
            if(acePresent){
                if(tempSum<21){
                    if(tempSum+10<21){
                        tempSum = tempSum+10
                        
                    }
                }
            }
            return tempSum
        }set{
            self.playerSum = newValue
        }
    }
    

    
    func initializePlayer(){
        let shoe = Shoe()
        playerCards.append(shoe.getCardFromShoe())
        playerCards.append(shoe.getCardFromShoe())
    }
    
    
    
    func isBlackJack() -> Bool {
        var tempSum = playerSum
        if  tempSum == 21 {
            return true
        }
        return false
    }
    
    func isBusted() -> Bool {
        var tempSum = playerSum
        
        if tempSum > 21 {
            return true
            //println(" value of sum is \(tempSum)")
        }
        return false
        
    
    }
    
    
    func getStringOfCards(playerCards :[Int]) -> String {
        if(playerCards.count==0){
            return ""
        }
        var temp = ""
        if(playerCards[0]==1){
            var tempString = String(playerCards[0])+" ACE"
        }else{
            temp = String(playerCards[0])
        }
        
        if(playerCards.count>1){
            for i in 2...playerCards.count{
                if(playerCards[i-1]==1){
                    temp = temp + " : " + String(playerCards[i-1])+" ACE"
                }else{
                    temp = temp + " : " + String(playerCards[i-1])
                }
            }
        }
        return temp
    }

}
