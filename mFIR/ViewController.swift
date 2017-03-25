//
//  ViewController.swift
//  mFIR
//
//  Created by Pham Van Thien on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit
import CoreData





class ViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource{
    var results : NSArray?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        test()
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        // INSERT
        let facilityTypeData = NSEntityDescription.insertNewObject(forEntityName: Databases.TABLE_FACILITY_TYPE, into:  context)
        facilityTypeData.setValue("234", forKey: Databases.FACILITY_TYPE_ID)
        facilityTypeData.setValue("phong thuc hanh", forKey: Databases.FACILITY_TYPE_NAME)
        facilityTypeData.setValue("pham thi nguyet hue", forKey: Databases.DESCRIPTION)

        do {
            try context.save()
            print("thanh cong")
        }
        catch {
            print("Error!")
        }
        
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: Databases.TABLE_FACILITY_TYPE)
        request.returnsObjectsAsFaults = false
        results = try! context.fetch(request) as NSArray?
        
        if (results!.count>0){
            for res in results! {
                print(res)
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        let aux = results![(indexPath as NSIndexPath).row] as! NSManagedObject
        cell.textLabel?.text = aux.value(forKey: Databases.FACILITY_TYPE_ID) as? String
        cell.textLabel!.text = aux.value(forKey: Databases.FACILITY_TYPE_NAME) as? String
        cell.textLabel!.text = aux.value(forKey: Databases.DESCRIPTION) as? String
        return cell
        
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return results!.count
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)-> String?  {
        return "TuxMania"
    }

    // >>>>>> vinh test <<<< ===============
    func test(){
        // facility ============================
        let postFacility = [
            POST.facility_id: "2"
        ]
        
        FirServices.loadData(requestId: Constants.REQUEST_ID.LIST_FACILITY, post: postFacility){
            data in
            
            guard let data = data as? [Facility] else{
                print("Loading data error!")
                return
            }
            
            // print test data
            for item in data{
                print("FACILITY: " + item.id + " - " + item.rootId)
            }
            
        }
        // ============================
        
        
        // login ============================
        let postlogin = [
            POST.imei: ""
        ]
        
        FirServices.loadData(requestId: Constants.REQUEST_ID.LOGIN, post: postlogin){
            data in
            
            guard let data = data as? Account else{
                print("Loading data error!")
                return
            }
            
            // print test data
            print("LOGIN: " + data.userName)
        }
        // ============================
        
        
        // issue ============================
        let postIssue = [
            POST.facility_issue_id: "76",
            POST.from_date: "",
            POST.thru_date: ""
        ]
        
        FirServices.loadData(requestId: Constants.REQUEST_ID.LIST_FACILITY_ISSUE, post: postIssue){
            data in
            
            guard let data = data as? [Issue] else{
                print("Loading data error!")
                return
            }
            
            // print test data
            for item in data{
                print("ISSUE: " + item.facilityName!)
            }
        }
        // ============================
        
        
        // component type ============================
        let postComponentType = [
            POST.facility_component_type_id: "1"
        ]
        
        FirServices.loadData(requestId: Constants.REQUEST_ID.LIST_FACILITY_COMPONENT_TYPE, post: postComponentType){
            data in
            
            guard let data = data as? [ComponentType] else{
                print("Loading data error!")
                return
            }
            
            // print test data
            for item in data{
                print("COMPONENT TYPE: " + item.componentTypeName)
            }
        }
        // ============================
        
        // relationship ============================
        let postRelationship = [
            POST.facility_type_id: "4004",
            POST.facility_component_type_id: "1"
        ]
        
        FirServices.loadData(requestId: Constants.REQUEST_ID.RELATIONSHIP, post: postRelationship){
            data in
            
            guard let data = data as? [Relationship] else{
                print("Loading data error!")
                return
            }
            
            // print test data
            for item in data{
                print("RELATIONSHIP: " + item.facilityTypeName)
            }
        }
        // ============================
    }
    
}

