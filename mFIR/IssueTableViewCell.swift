//
//  IssueTableViewCell.swift
//  mFIR
//
//  Created by Tran Bao Toan on 3/27/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit


protocol IssueTableViewCellDelegate {
    func btnChecked(cell: IssueTableViewCell)
    func textFieldDidChange(cell: IssueTableViewCell)
}

class IssueTableViewCell: UITableViewCell, BEMCheckBoxDelegate {

    @IBOutlet weak var lbComponent: UILabel!
    @IBOutlet weak var lbDescription: UITextField!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var checkbox: BEMCheckBox!

     var delegate: IssueTableViewCellDelegate?
    
       var listChecked: Array<ReportIssue> = Array()
    
    @IBAction func btnChecked(_ sender: Any) {
        if let _ = delegate {
            delegate?.btnChecked(cell: self)
        }
    }

    
    var reportIssue: ReportIssue! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI(){
        lbComponent.text = reportIssue.componentName
        checkbox.setOn(reportIssue.checked, animated: false)
        checkbox.delegate = self
        btnCamera.isHidden = true
        lbDescription.isHidden = false
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        if(checkBox.on){
            lbDescription.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            print("Check")
        } else {
            lbDescription.text = ""
            print("UnCheck")
        }
    }
    func textFieldDidChange(_ textField: UITextField) {
        if let _ = delegate {
            delegate?.textFieldDidChange(cell: self)
        }
//        print(lbDescription.text!)
    }

}