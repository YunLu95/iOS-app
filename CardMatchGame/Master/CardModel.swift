//
//  CardModel.swift
//  CardMatchGame
//
//
//  Copyright © 2019 Yun Lu. All rights reserved.
//

import Foundation

class CardModel {
    let emojiChoices=["👽","😈","🤡","👿","🤢","🎃","😺","💩","👾","🤠","👺","👹","🤖","🌛","🌜","🌟","⛄️","✨"]
    func getCards () -> [Card] {
        
        var cardsArray = [Card]()
        
        
        for _ in 1...18{ //TODO: replace variable by number in menuviewcontroller.
           
            
            let radomNumberOfPair = Int(arc4random_uniform(18))
            print(radomNumberOfPair)
            let cardOne = Card()
            cardOne.cardLabel = emojiChoices[radomNumberOfPair]
            print(cardOne.cardLabel)
            cardsArray.append(cardOne)
            //create matched card
            let cardTwo = Card()
            
            cardTwo.cardLabel = emojiChoices[radomNumberOfPair]
             print(cardTwo.cardLabel)
            cardsArray.append(cardTwo)
            
        }
        return cardsArray
    }
    
}
