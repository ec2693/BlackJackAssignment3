//
//  HandStatus.swift
//  BlackJackExtension
//
//  Created by Era Chaudhary on 3/4/15.
//  Copyright (c) 2015 Era Chaudhary. All rights reserved.
//

import Foundation
enum PlayerStatus: String {
    //May carry busted , blackjack , stand , won , lost
    case Busted = "busted"
    case BlackJack = "blackjack"
    case Stand = "stand"
    case Won = "won"
    case Lost = "Lost"
    case Turn = "turn"
    case Statue = "statue"
}