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
    
    
    
    
    
    
    
    func test(){
        
        // facility ============================
        let postFacility = [
            POST.facility_id: "0"
        ]
        
        FirServices.loadData(requestId: Constants.REQUEST_ID.LIST_FACILITY, post: postFacility){
            data in
            
            guard let data = data as? [Facility] else{
                print("Loading data error!")
                return
            }
            
            // print test data
            print("FACILITY: \(data.count)")
            
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
            POST.facility_issue_id: "0",
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
            print("ISSUE: \(data.count)")
        }
        // ============================
        
        
        // component type ============================
        let postComponentType = [
            POST.facility_component_type_id: "0"
        ]
        
        FirServices.loadData(requestId: Constants.REQUEST_ID.LIST_FACILITY_COMPONENT_TYPE, post: postComponentType){
            data in
            
            guard let data = data as? [ComponentType] else{
                print("Loading data error!")
                return
            }
            
            // print test data
            print("COMPONENT TYPE: \(data.count)")
        }
        // ============================
        
        
        // relationship ============================
        let postRelationship = [
            POST.facility_type_id: "0",
            POST.facility_component_type_id: "0"
        ]
        
        FirServices.loadData(requestId: Constants.REQUEST_ID.RELATIONSHIP, post: postRelationship){
            data in
            
            guard let data = data as? [Relationship] else{
                print("Loading data error!")
                return
            }
            
            // print test data
            print("RELATIONSHIP: \(data.count)")
        }
        // ============================
        
        
        // facility type ============================
        let postFacilityType = [
            POST.facility_type_id: "0"
        ]
        
        FirServices.loadData(requestId: Constants.REQUEST_ID.LIST_FACILITY_TYPE, post: postFacilityType){
            data in
            
            guard let data = data as? [FacilityType] else{
                print("Loading data error!")
                return
            }
            
            // print test data
            print("FACILITY TYPE: \(data.count)")
        }
        // ============================
        
        
        // instructor ============================
        let postInstructor = [
            POST.instructor_id_number: "010132007"
        ]
        
        FirServices.loadData(requestId: Constants.REQUEST_ID.LIST_INSTRUCTOR, post: postInstructor){
            data in
            
            guard let data = data as? [Instructor] else{
                print("Loading data error!")
                return
            }
            
            // print test data
            print("INSTRUCTOR: \(data.count)")
        }
        // ============================
        
        
        // student ============================
        let postStudent = [
            POST.student_id_number: "091579049"
        ]
        
        FirServices.loadData(requestId: Constants.REQUEST_ID.LIST_STUDENT, post: postStudent){
            data in
            
            guard let data = data as? [Student] else{
                print("Loading data error!")
                return
            }
            
            // print test data
            print("STUDENT: \(data.count)")
        }
        // ============================
        
        
        // issue status ============================
        FirServices.loadData(requestId: Constants.REQUEST_ID.ISSUE_STATUS, post: [:]){
            data in
            
            guard let data = data as? [IssueStatus] else{
                print("Loading data error!")
                return
            }
            
            // print test data
            print("ISSUE STATUS: \(data.count)")
        }
        // ============================
        
        
        // issue by facility ============================
        let postIssueByFacility = [
            POST.facility_id: "0"
        ]
        
        FirServices.loadData(requestId: Constants.REQUEST_ID.ISSUE_BY_FACILITY, post: postIssueByFacility){
            data in
            
            guard let data = data as? [Issue] else{
                print("Loading data error!")
                return
            }
            
            // print test data
            print("ISSUE BY FACILITY: \(data.count)")
        }
        // ============================
        
        
        
    }
}

