//
//  CardModel.swift
//  CardMatchGame
//
//  Copyright © 2019 Yun Lu. All rights reserved.
//

import Foundation

class CardModel {
    let emojiChoices=["👽","😈","🤡","👿","🤢","🎃","😺","💩","👾","🤠","👺","👹","🤖","🌛","🌜","🌟","⛄️","✨"]
    var number = 0
    
    var generatedNumbers = [Int]()
    
    func setGridSize(_ sender: Int) -> Int{
        number = sender
        return number
    }
    
    func getCards (number : Int ) -> [Card] {
        
        var cardsArray = [Card]()
        
        
        while generatedNumbers.count < ( number*number / 2 ){ //TODO: replace variable by number in menuviewcontroller.
            let radomNumberOfPair = Int(arc4random_uniform(18))
            //generate unique random number
            if generatedNumbers.contains( Int(radomNumberOfPair) ) == false {
                
                print(radomNumberOfPair)
                generatedNumbers.append(Int(radomNumberOfPair))
                let cardOne = Card()
                cardOne.cardLabel = emojiChoices[radomNumberOfPair]
                print(cardOne.cardLabel)
                cardsArray.append(cardOne)
                //create matched card
                let cardTwo = Card()
                cardTwo.cardLabel = emojiChoices[radomNumberOfPair]
                 print(cardTwo.cardLabel)
                cardsArray.append(cardTwo)
                print(generatedNumbers)
            }
        }
        
        for i in 0...generatedNumbers.count-1{
            let index = Int(arc4random_uniform(UInt32(cardsArray.count-1)))
            let temp = cardsArray[i]
            cardsArray[i] = cardsArray[index]
            cardsArray[index] = temp
        }
        return cardsArray
    }
    
}
