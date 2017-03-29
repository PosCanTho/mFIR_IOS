//
//  sideMenuController.swift
//  mFIR
//
//  Created by lehoangdung on 3/28/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class SideMenuController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //MARK: *** data model
    let ids = ["sideUser", "sideHomeID", "sideNotificationsID", "sideSettingsID", "sideLogout"]
    //UI:
    
    //Controller
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ids.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ids[indexPath.row], for: indexPath)
        return cell
    }
}
