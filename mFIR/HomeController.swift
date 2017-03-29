//
//  HomeController.swift
//  mFIR
//
//  Created by lehoangdung on 3/25/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class HomeController: UIViewController{
    //MARK: ****UI ELEMENT
    @IBOutlet weak var btnNotifications: UIButton!
    @IBOutlet weak var btnSettings: UIButton!
    
    
    //MARK: *** UI EVENTS
//    @IBAction func btnNotifications(_ sender: UIButton) {
//        performSegue(withIdentifier: "SegueNotifications", sender: self)
//    }
//    @IBAction func btnSettings(_ sender: UIButton) {
//        performSegue(withIdentifier: "SegueSetting", sender: self)
//    }
    
    
    //MARK: ***UI CONTROLLER
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSideMenu()
    }
}
