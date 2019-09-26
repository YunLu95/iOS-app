//
//  MenuViewController.swift
//  CardMatchGame
//
//  Created by panxingyang on 9/24/19.
//  Copyright © 2019 Yun Lu. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

//    @IBOutlet var MenuViewController: UIView!
    @IBOutlet var MenuView: UIView!
    
    @IBOutlet weak var menuName: UITextField!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button6: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(MenuView)
        // Do any additional setup after loading the view.
        
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
