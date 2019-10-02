//
//  ViewController.swift
//  CardMatchGame
//
//  Copyright © 2019 Yun Lu. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    var sizeOfGrid = 2
    
    private let spacing : CGFloat = 10.0

    var model = CardModel()
    
    var cardArray = [Card]()
    var flippedCard : IndexPath?
    
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        menuBtn.addTarget(self, action: #selector(menuBtnPressed), for: UIControl.Event.touchUpInside)
        cardArray = model.getCards(number: sizeOfGrid)
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionView?.collectionViewLayout = layout
        
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let menuVC = segue.destination as? MenuViewController {
            menuVC.delegate = self
        }
    }
    
    
    @IBAction func menuBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "menuSegue", sender: self)

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
    
    
    // function used to get cells auto sized
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCardPerRow: CGFloat = CGFloat(sizeOfGrid);
        let spacingBetweenCells: CGFloat = 20;
        let totalSpacing = (2 * self.spacing) + ( (numberOfCardPerRow - 1) * spacingBetweenCells )
        
        if let collection = self.collectionView{
            let width = (collection.bounds.width - totalSpacing ) / numberOfCardPerRow
            let height = (collection.bounds.height - totalSpacing) / numberOfCardPerRow
            return CGSize(width: width, height: height)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    
}
extension MasterViewController: MenuViewControllerDelegate{
    
    func buttonPressed(size: Int) {
        
        cardArray.enumerated().forEach { (index, card) in
            let indexPath = IndexPath(item: index, section: 0)
            let cell = collectionView.cellForItem(at: indexPath ) as? CollectionViewCell
            cell?.filpBack()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.sizeOfGrid = size
            self.cardArray = self.model.getCards(number: size)
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
        
        dismiss(animated: true)
    }
}


