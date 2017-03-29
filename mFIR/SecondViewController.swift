//
//  SecondViewController.swift
//  mFIR
//
//  Created by Tran Bao Toan on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var arrayComponents = [String]()
    
    @IBOutlet weak var lbFacility: UILabel!
    
    @IBOutlet weak var tableViewComponentsReported: UITableView!
    var Facility = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbFacility.text = Facility
        
        arrayComponents = ["Đèn/Điện","Cable/Wifi","Bàn/Ghế/Tủ","A"]
        tableViewComponentsReported.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SecondViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayComponents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentCell")!
        cell.textLabel?.text = arrayComponents[indexPath.row]
        return cell
    }
    
}
