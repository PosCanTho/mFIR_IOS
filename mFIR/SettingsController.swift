//
//  SettingsController.swift
//  mFIR
//
//  Created by lehoangdung on 3/25/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
    //MARK: **** UI Element
    @IBOutlet weak var btnBack: UIButton!
    
    
    //MARK: UI Events
    @IBAction func btnBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: UI Controller
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
