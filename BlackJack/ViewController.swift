//
//  ViewController.swift
//  BlackJackExtension
//
//  Created by Era Chaudhary on 3/3/15.
//  Copyright (c) 2015 Era Chaudhary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var bet1: UITextField!
    
    @IBOutlet weak var bet2: UITextField!
    
    @IBOutlet weak var bet3: UITextField!
    
    @IBOutlet weak var bet4: UITextField!
    
    @IBOutlet weak var cards1: UILabel!
    
    @IBOutlet weak var cards2: UILabel!
    
    @IBOutlet weak var cards3: UILabel!
    
    @IBOutlet weak var cards4: UILabel!
    
    @IBOutlet weak var dealerCards: UILabel!
    
    @IBOutlet weak var state: UILabel!
    
    @IBOutlet weak var balance: UILabel!
    
    
    var playerList:[Player] = []
    
    var shoe = Shoe()
    
    var dealer  = Dealer()
    
    //var players = Player()
    
    var numberOfGames = 5
    
    var numberOfPlayers :Int = 2
    
    var numberOfDecksInShoe :Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func deal(sender: UIButton) {
        
        //clearScreen()
        
        
        if numberOfGames%5 == 0 {
            shoe.createShoe(numberOfDecksInShoe)
        }
        dealer.initializeDealer()
        numberOfGames++;
        for i in 1...numberOfPlayers {
            initialize(i)
            println(i)
            //var player = playerList[i-1]
            
            //validations(playerList[i-1])
        }
        println(playerList[0])
        display()
    }
    
    
    
    
    @IBAction func hit(sender: UIButton) {
        for i in 1...numberOfPlayers{
            //println(playerList[i]);
            var player = playerList[i-1]
            
            if(playerList[i-1].playerStatus == PlayerStatus.Turn){
                println("insideHit")
                player.playerCards.append(shoe.getCardFromShoe())
                if(player.playerSum == 21){
                    playerList[i-1].playerStatus = PlayerStatus.BlackJack
                    display()
                    if(i != numberOfPlayers){
                        playerList[i].playerStatus = PlayerStatus.Turn
                    }
                    return
                }else if(player.playerSum>21){
                    println("isBusted")
                    playerList[i-1].playerStatus = PlayerStatus.Busted
                    display()
                    if(i != numberOfPlayers){
                        playerList[i].playerStatus = PlayerStatus.Turn
                    }else if (i == numberOfPlayers){
                        dealerChance()
                        
                    }
                    return
                }
                println(playerList[0])
                display()
            }
        }
        
        
        
    }
    
    @IBAction func stand(sender: AnyObject) {
        var allPlayersPlayed = true
        for i in 1...numberOfPlayers{
            var player = playerList[i-1]
            if(player.playerStatus == PlayerStatus.Turn){
                player.playerStatus = PlayerStatus.Stand
                if(i != numberOfPlayers){
                    playerList[i].playerStatus = PlayerStatus.Turn
                }
                break
            }
        }
        for i in 1...numberOfPlayers{
            var player = playerList[i-1]
            if(player.playerStatus == PlayerStatus.Turn){
                allPlayersPlayed = false
            }
        }
        if(allPlayersPlayed){
            dealerChance()
        }
    }
    
    
    func clearScreen() {
        for i in 1...4{
            playerList = []
            getCurrentPlayer(i).text = ""
            dealerCards.text = ""
            dealer = Dealer()
            
        }
        
    }
    
    func getCurrentPlayer(index : Int) -> UILabel {
        switch index{
        case 1:
            return cards1
        case 2:
            return cards2
        case 3:
            return cards3
        case 4:
            return cards4
            
        default:
            return cards1
        }
    }
    
    
    
    
    
    func initialize(i:Int){
        // for i in 1...numberOfPlayers {
        var players = Player()
        players.initializePlayer()
        players.playerBet = getPlayerBet(i-1)
        if(i==1){
            println(" inside initialze \(i)")
            players.playerStatus = PlayerStatus.Turn
        }else{
            players.playerStatus = PlayerStatus.Statue
        }
        playerList.append(players)
        //}
    }
    
    
    
    func validations(var player : Player) {
        if(player.isBlackJack()){
            changeBalance(player,isPlayerWon : true)
        }else if(player.isBusted()){
            changeBalance(player,isPlayerWon : false)
        }
    }
    
    
    
    
    func getPlayerBet(index : Int) -> Int {
        switch index{
        case 1:
            return bet1.text.toInt()!
        case 2:
            return bet2.text.toInt()!
        case 3:
            return bet3.text.toInt()!
        case 4:
            return bet4.text.toInt()!
            
        default:
            return 0
        }
    }
    
    
    
    func changeBalance(var player : Player , var isPlayerWon : Bool) {
        if(isPlayerWon){
            player.balance = player.balance + player.playerBet
        }else{
            player.balance = player.balance - player.playerBet
        }
    }
    
    
    func display(){
        var index:Int = 1;
        var i:Int = 0
        balance.text = ""
        state.text = ""
        for i = numberOfPlayers; i > 0; i-- {
            var player = playerList[i-1]
            var currentPlayer = getCurrentPlayer(i)
            currentPlayer.text = player.getStringOfCards(player.playerCards)
            balance.text = balance.text! + String(index) + ": " + String(playerList[i-1].balance) + " , "
            if(player.playerStatus == PlayerStatus.BlackJack || player.playerStatus == PlayerStatus.Busted ||
                player.playerStatus == PlayerStatus.Turn || player.playerStatus == PlayerStatus.Stand){
                    state.text = state.text! + String(i) + ": " + player.playerStatus.rawValue+","
            }
            index = index+1
        }
        println(cards1.text)
        println(cards2.text)
        displayDealer(false)
    }
    
    
    
    
    func dealerChance() {
        
        while(dealer.dealerSum<16){
            dealer.dealerCards.append(shoe.getCardFromShoe())
        }
        println("dealer Card sum after stand \(dealer.dealerSum)")
        println("dealer Cards \(dealer.dealerCards)")
        var dealer_sum = dealer.dealerSum
        for player in playerList{
            
            if(dealer_sum > 21){
                //Loop through all Players and check each status .
                if(player.playerStatus == PlayerStatus.Stand){
                    player.playerStatus = PlayerStatus.Won
                    changeBalance(player,isPlayerWon : true)
                }
                continue
            }
            
            if(dealer_sum > player.playerSum && player.playerStatus == PlayerStatus.Stand){
                player.playerStatus =  PlayerStatus.Lost
                changeBalance(player,isPlayerWon : false)
            }else if dealer_sum < player.playerSum && player.playerStatus == PlayerStatus.Stand {
                player.playerStatus =  PlayerStatus.Won
                changeBalance(player,isPlayerWon : true)
            }else{
                player.playerStatus =  PlayerStatus.Statue
                
            }
            
        }
        displayDealer(true)
        display()
    }
    
    func displayDealer(var showFullCards : Bool){
        var dealer_card = dealer.dealerCards
        
        if(!showFullCards){
            dealerCards.text = "X"
        }else{
            dealerCards.text = String(dealer_card[0])
        }
        for var i = dealer_card.count ; i>0 ; i-- {
            dealerCards.text = dealerCards.text! + " , " + String(dealer_card[i-1])
        }
        
    }
    
    
    
    
    
}










