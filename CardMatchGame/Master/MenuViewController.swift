//
//  MenuViewController.swift
//  CardMatchGame
//
//  Created by panxingyang on 9/24/19.
//  Copyright © 2019 Yun Lu. All rights reserved.
//

import UIKit
class MenuViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet var MenuView: UIView!
    @IBOutlet weak var menuName: UITextField!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button6: UIButton!
   // @IBOutlet weak var doneButton: UIButton!
    var sizeChoosed = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(MenuView)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismiss(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func button2pressed(_ sender: UIButton){
        self.sizeChoosed = 2
//        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "size2Segue", sender: self)
        
    }
    
    @IBAction func button4pressed(_ sender: UIButton){
        self.sizeChoosed = 4
        performSegue(withIdentifier: "size4Segue", sender: self)
        
    }
    
    @IBAction func button6pressed(_ sender: UIButton){
        self.sizeChoosed = 6
        performSegue(withIdentifier: "size6Segue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mastervc = segue.destination as! MasterViewController
        mastervc.sizeOfGrid = sizeChoosed
    }

}
extension MenuViewController: UITextFieldDelegate{
    
}
