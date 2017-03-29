//
//  IssueViewController.swift
//  mFIR
//
//  Created by Tran Bao Toan on 3/25/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class IssueViewController: UITableViewController,IssueTableViewCellDelegate {

//    @IBOutlet weak var tableViewIssue: UITableView!
  
    var arrayIssue = [String]()
//    var reportIssues = TIBReportIssue.getAll()
    var reportIssues: [ReportIssue]?
//    var selectedCellIndexPath: IndexPath?
//    let selectedCellHeight: CGFloat = 95.0
//    let unselectedCellHeight: CGFloat = 44.0
    var listChecked: Array<ReportIssue> = Array()
    var list:Array<ReportIssue> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableViewIssue.dataSource = self
        list = TIBReportIssue.getAll()
        print(list.count)
        self.getData()
    }
    func getData() {
        self.reportIssues = TIBReportIssue.getAll()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidChange(cell: IssueTableViewCell){
        
        print(cell.lbDescription.text!)
    }
    
    func btnChecked(cell: IssueTableViewCell) {
        //Get the indexpath of cell where checkbox was checked
        let indexPath = self.tableView.indexPath(for: cell)
       // cell.lbDescription.text
        reportIssues?[indexPath!.row].checked = cell.checkbox.on
        if (cell.checkbox.on) {
    

        } else {
        
       
        }
               print(indexPath!.row)
//        if selectedCellIndexPath != nil && selectedCellIndexPath == indexPath  {
//                selectedCellIndexPath = nil
//        } else {
//            if cell.checkbox.on {
//                selectedCellIndexPath = indexPath
//            }
//        }
//        tableView.beginUpdates()
//        tableView.endUpdates()
//        if selectedCellIndexPath != nil {
//            // This ensures, that the cell is fully visible once expanded
//            tableView.scrollToRow(at: indexPath!, at: .none, animated: true)
//        }
    }

}

extension IssueViewController {
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if selectedCellIndexPath == true {
//            return selectedCellHeight
//        }
//        return unselectedCellHeight
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportIssues!.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssueCell") as! IssueTableViewCell
        cell.reportIssue = reportIssues?[indexPath.row]
        cell.delegate = self
        return cell
    }
    
}
