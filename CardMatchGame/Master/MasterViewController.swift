//
//  ViewController.swift
//  CardMatchGame
//
//  Copyright © 2019 Yun Lu. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    var sizeOfGrid = 2
    let emojiChoices=["👽","😈","🤡","👿","🤢","🎃","😺","💩","👾","🤠","👺","👹","🤖","🌛","🌜","🌟","⛄️","✨"]
    private let spacing : CGFloat = 10.0
   // private let numberOfCardPerRow
    var model = CardModel()
    
    var cardArray = [Card]()
    var flippedCard : IndexPath?
    
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        menuBtn.addTarget(self, action: #selector(menuBtnPressed), for: UIControl.Event.touchUpInside)
       // model.setGridSize(sizeOfGrid)
        cardArray = model.getCards(number: sizeOfGrid)
        
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionView?.collectionViewLayout = layout
        
       
    }
    

    func transitionToViewController (){
        let controller = MenuViewController()
        controller.willMove(toParent: self)
        let current = children.first
        addChild(controller)
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
        
        current?.willMove(toParent: nil)
        current?.view.removeFromSuperview()
        current?.didMove(toParent: nil)
    
    }
    
    
    @IBAction func menuBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "menuSegue", sender: self)
       // print("Menu pressed!")

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let numberOfCards = sizeOfGrid * sizeOfGrid
        return numberOfCards
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CollectionViewCell

        cell.setCard(cardArray[indexPath.row], indexPath)
        
        cell.cardLabel.text = cardArray[indexPath.row].cardLabel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        let card = cardArray[indexPath.row]
        print(card.cardLabel)
        if card.isFlipped == false && card.isMatched == false {
            //flip card
            cell.flip()
            card.isFlipped = true
            //check if there is any other flipped card
            if(flippedCard == nil){
                flippedCard = indexPath
            }else{
                //perform matching
                cardMatches(indexPath)
//                checkGameEnd()
            }
        }
    }
    
    func cardMatches (_ secondFlippedCardIndex : IndexPath){
        let cardOneCell = collectionView.cellForItem(at: flippedCard!) as? CollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CollectionViewCell
        let cardOne = cardArray[flippedCard!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        if (cardOne.cardLabel == cardTwo.cardLabel){
            cardOne.isMatched = true
            cardTwo.isMatched = true
            //check if game end here
            checkGameEnd()
            
        }else{
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            cardOneCell?.filpBack()
            cardTwoCell?.filpBack()
            
        }
        flippedCard = nil;
        
    }
    func checkGameEnd(){
        //if no card left unmatched , user won pop up notification.
        var won = true
        for card in cardArray {
            if(card.isMatched == false){
                won = false
                break
            }
        }
        var title = ""
        var message = ""
        if won == true {
            title = "Congratulations!"
            message = "You've Won!"
        
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "One More Time!", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    
    
    // function I tried to use to get cells auto sized but not working yet.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCardPerRow: CGFloat = CGFloat(sizeOfGrid);
        let spacingBetweenCells: CGFloat = 20;
        let totalSpacing = (2 * self.spacing) + ( (numberOfCardPerRow - 1) * spacingBetweenCells )
        
        if let collection = self.collectionView{
            let width = (collection.bounds.width - totalSpacing ) / numberOfCardPerRow
            return CGSize(width: width, height: width)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    
}


