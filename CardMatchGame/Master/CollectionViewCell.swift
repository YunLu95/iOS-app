//
//  CollectionViewCell.swift
//  CardMatchGame
//
//
//  Copyright © 2019 Yun Lu. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardLabel: UILabel!
    
    @IBOutlet weak var backImageView: UIImageView!
    var card:Card?
    
    func setCard(_ card: Card , _ indexPath: IndexPath){
        self.card = card
        
    }

    func flip(){
        UIView.transition(from: backImageView, to: cardLabel, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
    }
    
    func filpBack(){
        UIView.transition(from: cardLabel, to: backImageView, duration: 0.5, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
    }
    
}
