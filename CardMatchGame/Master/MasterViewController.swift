//
//  ViewController.swift
//  CardMatchGame
//
//  Created by panxingyang on 9/18/19.
//  Copyright © 2019 Yun Lu. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    let sizeOfGrid = 4
    let emojiChoices=["👽","😈","🤡","👿","🤢","🎃","😺","💩","👾","🤠","👺","👹","🤖","🌛","🌜","🌟","⛄️","✨"]
    private let spacing : CGFloat = 10.0
   // private let numberOfCardPerRow
    var model = CardModel()
    var cardArray = [Card]()
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        menuBtn.addTarget(self, action: #selector(menuBtnPressed), for: UIControl.Event.touchUpInside)
        cardArray = model.getCards()
        print()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
       
    }
//    func addMenuScreen(){
//
//        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
//        guard let controller = storyboard.instantiateInitialViewController() as? MenuViewController else { return }
//        controller.willMove(toParent: self)
//        addChild(controller)
//        self.view.addSubview(controller.view)
//        controller.didMove(toParent: self)
//
//
//    }
    
    

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
        print("Menu pressed!")

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
        if card.isFlipped == false {
            //flip card
            cell.flip()
            card.isFlipped = true
        }else{
            cell.filpBack()
            card.isFlipped = false
        }
        
        
    }
    
    
    // function I tried to use to get cells auto sized but not working yet.
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCardPerRow: CGFloat = CGFloat(sizeOfGrid);
        let spacingBetweenCells: CGFloat = 10;
        let totalSpacing = (2 * self.spacing) + ( (numberOfCardPerRow - 1) * spacingBetweenCells )
        
        if let collection = self.collectionView{
            let width = (collection.bounds.width - totalSpacing ) / numberOfCardPerRow
            return CGSize(width: width, height: width)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    
}


