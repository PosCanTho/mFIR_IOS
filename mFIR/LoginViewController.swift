//
//  ViewController.swift
//  mFIR-23-03
//
//  Created by Pham Van Thien on 3/23/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lbPassword: UILabel!
    @IBOutlet weak var checkbox: UIButton!
    
    var isRememberChecked:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        isRememberChecked = false;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func remember(_ sender: Any) {
        if isRememberChecked == true {
            isRememberChecked = false
            let imgUncheck: UIImage = UIImage(named: "ic_uncheck")!
            checkbox.setImage(imgUncheck, for: UIControlState.normal)
        }else{
            isRememberChecked = true;
            let imgChecked: UIImage = UIImage(named: "ic_checked")!
            checkbox.setImage(imgChecked, for: UIControlState.normal)
        }
        
    }
    
    @IBAction func signin(_ sender: Any) {
        
    }
    
}

