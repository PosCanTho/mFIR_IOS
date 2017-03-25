//
//  Uitls.swift
//  mFIR
//
//  Created by Pham Van Thien on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation
import UIKit

class Utils{
    
}

extension UIViewController{
    func showAlertOK(title:String, msg:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        let btnOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertComfirmOK(title:String, msg:String, callback:@escaping (Int) -> Void ){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        let btnCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) { (UIAlertAction) in
            callback(0)
        }
        let btnOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (UIAlertAction) in
            callback(1)
        }
        
        alert.addAction(btnCancel)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
    }
}
