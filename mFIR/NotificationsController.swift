//
//  NotificationsController.swift
//  mFIR
//
//  Created by lehoangdung on 3/25/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class NotificationsController: UIViewController {
    
    //MARK: Data Model
    
    
    //MARK: *** UIElement
    @IBOutlet weak var txtData: UITextField!
    @IBOutlet weak var btnChuyenTrang: UIButton!
    
    
    //MARK: *** Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        addSideMenu()
    }
    //MARK: *** UI Events
    @IBAction func btnChuyenTrang(_ sender: UIButton) {
        performSegue(withIdentifier: "segueNotificationDetailID", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {// phương thức truyền tham số khi chuyển trang
        if segue.identifier == "segueNotificationDetailID" {
            let dest = segue.destination as! NotificationDetailController
            dest.data = "\(txtData.text!)"
            // truyền biến
        }
    }
    
    
}
