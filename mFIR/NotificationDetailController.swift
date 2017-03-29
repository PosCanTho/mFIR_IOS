//
//  NotificationDetailController.swift
//  mFIR
//
//  Created by lehoangdung on 3/29/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class NotificationDetailController: UIViewController{
    //MARK: data model
    var data = ""
    //MARK: **** UI Elements
    @IBOutlet weak var lblData: UILabel!
    
    
    //MARK: *** Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        lblData.text = data
    }
}
