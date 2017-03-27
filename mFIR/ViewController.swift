//
//  ViewController.swift
//  mFIR
//
//  Created by Pham Van Thien on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: ***UI Elements
    @IBOutlet weak var txt: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    //MARK: ***Ui Event
    @IBAction func btnLogin(_ sender: UIButton) {// chuyển trang Home
        performSegue(withIdentifier: "SegueHome", sender: self)
    }

    //MARK:  ***UI Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        addDoneButton(to: txt)
    }
    
    
    //truyền tham số chuyển trang
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // truyền biến sang trang Home tương tự Intent trong Android
//        if segue.identifier == "SegueHome" {
//            let dest = segue.destination as! HomeController // ép kiểu
//            dest.salary = <giatricantuyen>
//        }
    }

}

