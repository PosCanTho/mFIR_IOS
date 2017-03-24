//
//  ViewController.swift
//  mFIR
//
//  Created by Pham Van Thien on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        test()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

