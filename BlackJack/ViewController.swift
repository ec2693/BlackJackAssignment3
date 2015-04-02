//
//  ViewController.swift
//  BlackJack
//
//  Created by Era Chaudhary on 3/31/15.
//  Copyright (c) 2015 Era Chaudhary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBOutlet weak var player1Cards: UILabel!
    
    @IBOutlet weak var player1Balance:UILabel!
    
    @IBOutlet weak var player1Bet: UILabel!
    
    @IBOutlet weak var player2Cards: UILabel!
    
    @IBOutlet weak var player2Balance:UILabel!
    
    @IBOutlet weak var player2Bet: UILabel!
    
    @IBOutlet weak var bet1: UITextField!
    
    @IBOutlet weak var bet2: UITextField!
    
    @IBOutlet weak var player1View: UIView!
    
    @IBOutlet weak var dealerView: UIView!
    
    @IBOutlet weak var player2View: UIView!
    
    @IBOutlet weak var player1Card1: UIImageView!
    
    @IBOutlet weak var player1Card2: UIImageView!
   
    @IBOutlet weak var dealerCard1: UIImageView!
       
    @IBOutlet weak var player2Card1: UIImageView!
    @IBOutlet weak var cardsView: UIView!
    
    @IBOutlet weak var buttonsView: UIView!
    
    
    
    var backupPlayerCard1View = UIView()
    
    var backupPlayerCard2View = UIView()
    
    var playerViewBackUp = UIView()
    
    var playerList:[Player] = []
    
    var shoe = Shoe()
    
    var dealer  = Dealer()
    
    //var players = Player()
    
    var numberOfGames = 5
    
    var numberOfPlayers :Int = 2
    
    var numberOfDecksInShoe :Int = 2
    
    
    
    @IBAction func deal(sender: AnyObject) {
    
        clearScreen()
        
        
        if numberOfGames%5 == 0 {
            shoe.createShoe(numberOfDecksInShoe)
        }
        
        for i in 1...player1View.subviews.count-1{
            println(player1View.subviews[i])
        }
        
        for subview in player1View.subviews{
            println(subview)
            subview.removeFromSuperview()
        }
        player1View.addSubview(backupPlayerCard1View)
        player1View.addSubview(backupPlayerCard2View)
        
        
        dealer.initializeDealer()
        numberOfGames++;
        for i in 1...numberOfPlayers {
            initialize(i)
           // println(i)
            //var player = playerList[i-1]
            //validations(playerList[i-1])
        }
        display()
    }
    
    
    

    @IBAction func hit(sender: AnyObject) {
    
        for i in 1...numberOfPlayers{
            //println(playerList[i]);
            var player = playerList[i-1]
    
            if(playerList[i-1].playerStatus == PlayerStatus.Turn){
                println("insideHit")
                player.playerCards.append(shoe.getCardFromShoe())
                if(i == 1){
                    addCardsToView(player.playerCards,parentView: player1View, isPlayerView: true, currentView: player1Card1,addAllCards: false)
                }else{
                    addCardsToView(player.playerCards, parentView: player1View,  isPlayerView: false,  currentView: player1Card2,addAllCards: false)

                }
            }
            
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
        //for i in 1...4{
            playerList = []
            //getCurrentPlayer(i).text = ""
            //dealerCards.text = ""
            dealer = Dealer()
            
    }

   /* func getCurrentPlayer(index : Int) -> UILabel {
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
*/
    
    
    
    
    
    func initialize(i:Int){
        // for i in 1...numberOfPlayers {
        var players = Player()
        players.initializePlayer()
       // players.playerBet = getPlayerBet(i-1)
        if(i==1){
            println(" inside initialze \(i)")
            players.playerStatus = PlayerStatus.Turn
        }else{
            players.playerStatus = PlayerStatus.Statue
        }
        playerList.append(players)
        
    }
    

    
    func validations(var player : Player) {
        if(player.isBlackJack()){
            changeBalance(player, isPlayerWon: true)
        }else if(player.isBusted()){
            changeBalance(player, isPlayerWon: false)
        }
    }
    
    
    
    
   /* func getPlayerBet(index : Int) -> Int {
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
    }*/
    
    
    
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
        //balance.text = ""
       // state.text = ""
        for i =   numberOfPlayers; i > 0; i-- {
            var player = playerList[i-1]
            if(i == 1){
                 addCardsToView(player.playerCards, parentView: player1View, isPlayerView: true, currentView: player1Card1,addAllCards:true)
            }else{
                addCardsToView(player.playerCards, parentView: player1View, isPlayerView: false, currentView: player1Card1,addAllCards:true)
            }
            
                        index = index+1
        }
                displayDealerCards(false)
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
        displayDealerCards(true)
        display()
    }
    
    func displayDealerCards(var showFullCards : Bool){
        var tempString = ""
        let widthStandard = 50
        let heightStandard = 75
        let xdiff : CGFloat = CGFloat(20)
        let ydiff : CGFloat = CGFloat(0)
        let dealerFrame = dealerCard1.frame.size
        let width1 = dealerFrame.width
        let height1 = dealerFrame.height
        let x = dealerCard1.frame.origin.x
        let y = dealerCard1.frame.origin.y
        for i in 1...dealer.dealerCards.count{
            if (i == 1){
                if(showFullCards){
                    let newCardView : UIView = createView(x, y: y , width : width1,height : height1, imageName: "card"+String(dealer.dealerCards[i-1]))
                    dealerView.addSubview(newCardView)
                    continue
                
                }else{
                    let newCardView : UIView = createView(x, y: y , width : width1,height : height1, imageName: "back");                   dealerView.addSubview(newCardView)
                    continue
                }
            }else{
                let newCardView : UIView  = createView(x + (CGFloat(i)*xdiff), y: y+(CGFloat(i)*ydiff), width : width1,height : height1, imageName: "card" + String(dealer.dealerCards[i-1]))
                        dealerView.addSubview(newCardView)
                
            }
            
            
        }
        
        
    }


    
    func createView(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, imageName: String) -> UIView{
        
        let Frame : CGRect = CGRectMake(x,y,width,height)
        var view : UIView = UIView(frame:Frame)
        var image = UIImage(named: imageName)
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone{
            image = imageWithImage(image!, scaledToSize:CGSize(width: 50,height:75))
            }
        let imageView =  UIImageView(image: image)
        view.addSubview(imageView)
        return view
        
    }
    
    
    func imageWithImage(image:UIImage,scaledToSize newSize: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        var newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
func addCardsToView(cards :[Int] ,parentView : UIView, isPlayerView : Bool, currentView :UIView, addAllCards : Bool){
    var xdiff : CGFloat = 0;
    var ydiff : CGFloat = 0;
    var currentStart = currentView.frame.size
    if(isPlayerView){
        xdiff = CGFloat(25)
        ydiff = CGFloat(25)
    }else{
        xdiff = CGFloat(-25)
        ydiff = CGFloat(25)
    }
    
    var width1 = currentStart.width
    var height1 = currentStart.height
    
    var x = currentView.frame.origin.x
    var y = currentView.frame.origin.y
    
    for i in 1...cards.count{
        if(i==1){
            let newCardView : UIView = createView(x, y: y , width : width1,height : height1, imageName: "card"+String(cards[i-1]))
            parentView.addSubview(newCardView)
            continue
        }else{
            let newCardView : UIView = createView(x+(CGFloat(i)*xdiff), y: y+(CGFloat(i)*ydiff), width: width1, height: height1, imageName: "card"+String(cards[i-1]))
        }
        
        
        }
    
    }
}
    


    
    
    
















