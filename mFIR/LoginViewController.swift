//
//  ViewController.swift
//  mFIR-23-03
//
//  Created by Pham Van Thien on 3/23/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lbPassword: UILabel!
    @IBOutlet weak var checkbox: UIButton!
    
    var isRememberChecked:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isRememberChecked = false;
        lbUsername.isHidden = true;
        lbPassword.isHidden = true;
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
        let username = tfUsername.text!
        let password = tfPassword.text!
        
        if(username.isEmpty){
            lbUsername.isHidden = false
            lbPassword.isHidden = true
        }else if(password.isEmpty){
            lbPassword.isHidden = false
            lbUsername.isHidden = true
        }else{
            lbUsername.isHidden = true
            lbPassword.isHidden = true
            
            showAlertComfirmOK(title: "mFIR", msg: "Do you want log out?", callback: {(processId: Int) -> Void in
                if(processId == 0){
                    print("Cancel")
                }else if(processId == 1)
                {
                    print("OK")
                }
            
            })
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

