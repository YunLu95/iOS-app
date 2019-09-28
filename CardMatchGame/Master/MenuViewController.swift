//
//  MenuViewController.swift
//  CardMatchGame
//
//  Created by panxingyang on 9/24/19.
//  Copyright © 2019 Yun Lu. All rights reserved.
//

import UIKit
class MenuViewController: UIViewController {
    
    @IBOutlet var MenuView: UIView!
    @IBOutlet weak var menuName: UITextField!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button6: UIButton!
   // @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(MenuView)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func button2pressed(_ sender: UIButton){
        //sizeOfGrid = 2;
        print("2 pressed!")
    }
    
    @IBAction func button4pressed(_ sender: UIButton){
        print("4 pressed!")

    }
    
    @IBAction func button6pressed(_ sender: UIButton){
        print("6 pressed!")

    }
    
//    @IBAction func doneButtonPressed(_ sender: UIButton) {
//        performSegue(withIdentifier: "masterSegue", sender: self)
//        print("Done Button Pressed!")
//    }
//
}
extension MenuViewController: UITextFieldDelegate{
    
}
