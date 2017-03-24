//
//  FirServices.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/23/17.
//  Copyright © 2017 Tống Thành Vinh. All rights reserved.
//

import Foundation

class FirServices {
    
    private static let user:String = "username=huynhducviet&password=UUNpZzQxYXN5VWY4MHIrL0FNN3hIaEtOU0VvPQ==&"
    
    // ============================
    static func loadData(requestId: Constants.REQUEST_ID, post: Dictionary<String, String>, callback: @escaping (_ data: Any) -> Void){
        
        switch requestId {
            
        case Constants.REQUEST_ID.LOGIN:
            FirServices.login(post: post, callback: callback)
            break
            
        case Constants.REQUEST_ID.LIST_FACILITY:
            FirServices.facility(post: post, callback: callback)
            break
            
        case Constants.REQUEST_ID.LIST_FACILITY_ISSUE:
            FirServices.facilityIssue(post: post, callback: callback)
            break
            
        case Constants.REQUEST_ID.LIST_FACILITY_COMPONENT_TYPE:
            FirServices.componentType(post: post, callback: callback)
            break
            
        case Constants.REQUEST_ID.RELATIONSHIP:
            FirServices.relationship(post: post, callback: callback)
            break
            
        case Constants.REQUEST_ID.LIST_FACILITY_TYPE:
            break
            
        case Constants.REQUEST_ID.LIST_INTRUCTOR:
            break
            
        case Constants.REQUEST_ID.LIST_STUDENT:
            break
            
        case Constants.REQUEST_ID.INSUPD_FACILITY_ISSUE:
            break
            
        case Constants.REQUEST_ID.ISSUE_STATUS:
            break
            
        case Constants.REQUEST_ID.ISSUE_BY_FACILITY:
            break
            
        case Constants.REQUEST_ID.REGISTER_FCMTOKEN:
            break
            
        case Constants.REQUEST_ID.LIST_RELATIONSHIP:
            break
            
        case Constants.REQUEST_ID.METHOD_FILE_FOR_FIR:
            break
            
        case Constants.REQUEST_ID.FILE_FOR_FIR:
            break
            
            
        }
    }
    // ============================
    
    
    // ============================
    private static func dataTask(
        url: String,
        post: String,
        callback: @escaping (_ json: Dictionary<String, Any>, _ error: String?) -> Void) {
        
        let urlRequest = URL(string: url)!
        var request = URLRequest(url: urlRequest)
        
        request.httpMethod = "POST"
        request.httpBody = post.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil
                else {
                    print("error=\(error)")
                    callback(Dictionary<String, AnyObject>(), error as! String?)
                    return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200
            {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                
            }
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as? [String:Any] {
                    
                    callback(json, nil)
                }
                
            } catch let err{
                print(err.localizedDescription)
            }
        }
        task.resume()
    }
    // ============================
    
    
    // ============================
    private static func login(post: Dictionary<String, String>, callback: @escaping (_ data: Any) -> Void){
        
        let postString = FirServices.user + POST.imei + "=" + post[POST.imei]!
        
        FirServices.dataTask(url: Constants.URL.API_LOGIN, post: postString){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                print("JSON error!")
                return
            }
            guard let instructorIdNumber = table[0]["INSTRUCTOR_ID_NUMBER"] as? String,
                let userName = table[0]["UserName"] as? String,
                let currentLastName = table[0]["CURRENT_LAST_NAME"] as? String,
                let roleType = table[0]["ROLE_TYPE"] as? String,
                let studentIdNumber = table[0]["STUDENT_ID_NUMBER"] as? String,
                let currentFirstName = table[0]["CURRENT_FIRST_NAME"] as? String,
                let userId = table[0]["USER_ID"] as? String,
                let currentMiddleName = table[0]["CURRENT_MIDDLE_NAME"] as? String
                else{
                    print("Parsing JSON error!")
                    return
            }
            
            let account = Account(
                userId: userId,
                userName: userName,
                studentIdNumber: studentIdNumber,
                instructorIdNumber: instructorIdNumber,
                currentLastName: currentLastName,
                currentMiddleName: currentMiddleName,
                currentFirstName: currentFirstName,
                roleType: roleType)
            
            callback(account)
        }
    }
    // ============================
    
    
    // ============================
    private static func facility(post: Dictionary<String, String>, callback: @escaping (_ data: Any) -> Void){
        
        let postString = FirServices.user + POST.facility_id + "=" + post[POST.facility_id]!
        
        var listFacility = [Facility]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_LIST_FACILITY, post: postString){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                print("JSON error!")
                return
            }
            for element in table{
                
                guard let id = element["FACILITY_ID"] as? String,
                    let name = element["FACILITY_NAME"] as? String,
                    let typeName = element["FACILITY_TYPE_NAME"] as? String,
                    let usageStatus = element["FACILITY_USAGE_STATUS"] as? String,
                    let rootId = element["ROOT_ROOT_FACILITY_ID"] as? String
                    else{
                        print("Parsing JSON error!")
                        return
                }
                let facility = Facility(id: id, name: name, typeName: typeName, usageStatus: usageStatus, rootId: rootId)
                listFacility.append(facility)
            }
            
            callback(listFacility)
        }
    }
    // ============================
    
    
    // ============================
    private static func facilityIssue(post: Dictionary<String, String>, callback: @escaping (_ data: Any) -> Void){
        
        let postString = FirServices.user + POST.facility_issue_id + "=" + post[POST.facility_issue_id]! + "&" + POST.from_date + "=" +  post[POST.from_date]! + "&" + POST.thru_date + "=" + post[POST.thru_date]!
        
        var listIssue = [Issue]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_LIST_FACILITY_ISSUE, post: postString){
            (json, error) in
            guard let table = json["Table"] as? [[String: Any]] else{
                print("JSON error!")
                return
            }
            
            for element in table{
                
                guard let facilityIssueId = element["FACILITY_ISSUE_ID"] as? String,
                    let facilityIssueCaseNumber = element["FACILITY_ISSUE_CASE_NUMBER"] as? String,
                    let sameFacilityIssueId = element["SAME_FACILITY_ISSUE_ID"] as? String,
                    let sameFacilityIssueCaseNumber = element["SAME_FACILITY_ISSUE_CASE_NUMBER"] as? String,
                    let facilityIssueReportDatetime = element["FACILITY_ISSUE_REPORT_DATETIME"] as? String,
                    let facilityIssueStatus = element["FACILITY_ISSUE_STATUS"] as? String,
                    let instructorIdNumber = element["INSTRUCTOR_ID_NUMBER"] as? String,
                    let studentIdNumber = element["STUDENT_ID_NUMBER"] as? String,
                    let facilityId = element["FACILITY_ID"] as? String,
                    let facilityName = element["FACILITY_NAME"] as? String,
                    let facilityTypeName = element["FACILITY_TYPE_NAME"] as? String,
                    let facilityComponentTypeId1 = element["FACILITY_COMPONENT_TYPE_ID_1"] as? String,
                    let facilityComponentTypeName1 = element["FACILITY_COMPONENT_TYPE_NAME_1"] as? String,
                    let facilityComponentIssueReport1 = element["FACILITY_COMPONENT_ISSUE_REPORT_1"] as? String,
                    let facilityComponentIssueStatus1 = element["FACILITY_COMPONENT_ISSUE_STATUS_1"] as? String,
                    let facilityComponentIssue_picture1 = element["FACILITY_COMPONENT_ISSUE_PICTURE_1"] as? String,
                    let facilityIssueResolverIdNumber1 = element["FACILITY_ISSUE_RESOLVER_ID_NUMBER_1"] as? String,
                    let facilityIssueResolvedDatetime1 = element["FACILITY_ISSUE_RESOLVED_DATETIME_1"] as? String,
                    let facilityIssueResolversNote1 = element["FACILITY_ISSUE_RESOLVERS_NOTE_1"] as? String,
                    let facilityComponentTypeId2 = element["FACILITY_COMPONENT_TYPE_ID_2"] as? String,
                    let facilityComponentTypeName2 = element["FACILITY_COMPONENT_TYPE_NAME_2"] as? String,
                    let facilityComponentIssueReport2 = element["FACILITY_COMPONENT_ISSUE_REPORT_2"] as? String,
                    let facilityComponentIssueStatus2 = element["FACILITY_COMPONENT_ISSUE_STATUS_2"] as? String,
                    let facilityComponentIssue_picture2 = element["FACILITY_COMPONENT_ISSUE_PICTURE_2"] as? String,
                    let facilityIssueResolverIdNumber2 = element["FACILITY_ISSUE_RESOLVER_ID_NUMBER_2"] as? String,
                    let facilityIssueResolvedDatetime2 = element["FACILITY_ISSUE_RESOLVED_DATETIME_2"] as? String,
                    let facilityIssueResolversNote2 = element["FACILITY_ISSUE_RESOLVERS_NOTE_2"] as? String,
                    let facilityComponentTypeId3 = element["FACILITY_COMPONENT_TYPE_ID_3"] as? String,
                    let facilityComponentTypeName3 = element["FACILITY_COMPONENT_TYPE_NAME_3"] as? String,
                    let facilityComponentIssueReport3 = element["FACILITY_COMPONENT_ISSUE_REPORT_3"] as? String,
                    let facilityComponentIssueStatus3 = element["FACILITY_COMPONENT_ISSUE_STATUS_3"] as? String,
                    let facilityComponentIssue_picture3 = element["FACILITY_COMPONENT_ISSUE_PICTURE_3"] as? String,
                    let facilityIssueResolverIdNumber3 = element["FACILITY_ISSUE_RESOLVER_ID_NUMBER_3"] as? String,
                    let facilityIssueResolvedDatetime3 = element["FACILITY_ISSUE_RESOLVED_DATETIME_3"] as? String,
                    let facilityIssueResolversNote3 = element["FACILITY_ISSUE_RESOLVERS_NOTE_3"] as? String,
                    let facilityComponentTypeId4 = element["FACILITY_COMPONENT_TYPE_ID_4"] as? String,
                    let facilityComponentTypeName4 = element["FACILITY_COMPONENT_TYPE_NAME_4"] as? String,
                    let facilityComponentIssueReport4 = element["FACILITY_COMPONENT_ISSUE_REPORT_4"] as? String,
                    let facilityComponentIssueStatus4 = element["FACILITY_COMPONENT_ISSUE_STATUS_4"] as? String,
                    let facilityComponentIssue_picture4 = element["FACILITY_COMPONENT_ISSUE_PICTURE_4"] as? String,
                    let facilityIssueResolverIdNumber4 = element["FACILITY_ISSUE_RESOLVER_ID_NUMBER_4"] as? String,
                    let facilityIssueResolvedDatetime4 = element["FACILITY_ISSUE_RESOLVED_DATETIME_4"] as? String,
                    let facilityIssueResolversNote4 = element["FACILITY_ISSUE_RESOLVERS_NOTE_4"] as? String,
                    let facilityComponentTypeId5 = element["FACILITY_COMPONENT_TYPE_ID_5"] as? String,
                    let facilityComponentTypeName5 = element["FACILITY_COMPONENT_TYPE_NAME_5"] as? String,
                    let facilityComponentIssueReport5 = element["FACILITY_COMPONENT_ISSUE_REPORT_5"] as? String,
                    let facilityComponentIssueStatus5 = element["FACILITY_COMPONENT_ISSUE_STATUS_5"] as? String,
                    let facilityComponentIssue_picture5 = element["FACILITY_COMPONENT_ISSUE_PICTURE_5"] as? String,
                    let facilityIssueResolverIdNumber5 = element["FACILITY_ISSUE_RESOLVER_ID_NUMBER_5"] as? String,
                    let facilityIssueResolvedDatetime5 = element["FACILITY_ISSUE_RESOLVED_DATETIME_5"] as? String,
                    let facilityIssueResolversNote5 = element["FACILITY_ISSUE_RESOLVERS_NOTE_5"] as? String
                    else{
                        print("Parsing JSON error!")
                        return
                }
                
                let issue = Issue(
                    facilityIssueId: facilityIssueId,
                    facilityIssueCaseNumber: facilityIssueCaseNumber,
                    sameFacilityIssueId: sameFacilityIssueId,
                    sameFacilityIssueCaseNumber: sameFacilityIssueCaseNumber,
                    facilityIssueReportDatetime: facilityIssueReportDatetime,
                    facilityIssueStatus: facilityIssueStatus,
                    instructorIdNumber: instructorIdNumber,
                    studentIdNumber: studentIdNumber,
                    facilityId: facilityId,
                    facilityName: facilityName,
                    facilityTypeName: facilityTypeName,
                    facilityComponentTypeId1: facilityComponentTypeId1,
                    facilityComponentTypeName1: facilityComponentTypeName1,
                    facilityComponentIssueReport1: facilityComponentIssueReport1,
                    facilityComponentIssueStatus1: facilityComponentIssueStatus1,
                    facilityComponentIssue_picture1: facilityComponentIssue_picture1,
                    facilityIssueResolverIdNumber1: facilityIssueResolverIdNumber1,
                    facilityIssueResolvedDatetime1: facilityIssueResolvedDatetime1,
                    facilityIssueResolversNote1: facilityIssueResolversNote1,
                    facilityComponentTypeId2: facilityComponentTypeId2,
                    facilityComponentTypeName2: facilityComponentTypeName2,
                    facilityComponentIssueReport2: facilityComponentIssueReport2,
                    facilityComponentIssueStatus2: facilityComponentIssueStatus2,
                    facilityComponentIssue_picture2: facilityComponentIssue_picture2,
                    facilityIssueResolverIdNumber2: facilityIssueResolverIdNumber2,
                    facilityIssueResolvedDatetime2: facilityIssueResolvedDatetime2,
                    facilityIssueResolversNote2: facilityIssueResolversNote2,
                    facilityComponentTypeId3: facilityComponentTypeId3,
                    facilityComponentTypeName3: facilityComponentTypeName3,
                    facilityComponentIssueReport3: facilityComponentIssueReport3,
                    facilityComponentIssueStatus3: facilityComponentIssueStatus3,
                    facilityComponentIssue_picture3: facilityComponentIssue_picture3,
                    facilityIssueResolverIdNumber3: facilityIssueResolverIdNumber3,
                    facilityIssueResolvedDatetime3: facilityIssueResolvedDatetime3,
                    facilityIssueResolversNote3: facilityIssueResolversNote3,
                    facilityComponentTypeId4: facilityComponentTypeId4,
                    facilityComponentTypeName4: facilityComponentTypeName4,
                    facilityComponentIssueReport4: facilityComponentIssueReport4,
                    facilityComponentIssueStatus4: facilityComponentIssueStatus4,
                    facilityComponentIssue_picture4: facilityComponentIssue_picture4,
                    facilityIssueResolverIdNumber4: facilityIssueResolverIdNumber4,
                    facilityIssueResolvedDatetime4: facilityIssueResolvedDatetime4,
                    facilityIssueResolversNote4: facilityIssueResolversNote4,
                    facilityComponentTypeId5: facilityComponentTypeId5,
                    facilityComponentTypeName5: facilityComponentTypeName5,
                    facilityComponentIssueReport5: facilityComponentIssueReport5,
                    facilityComponentIssueStatus5: facilityComponentIssueStatus5,
                    facilityComponentIssue_picture5: facilityComponentIssue_picture5,
                    facilityIssueResolverIdNumber5: facilityIssueResolverIdNumber5,
                    facilityIssueResolvedDatetime5: facilityIssueResolvedDatetime5,
                    facilityIssueResolversNote5: facilityIssueResolversNote5
                )
                listIssue.append(issue)
            }
            
            callback(listIssue)
        }
    }
    // ============================
    
    
    // ============================
    private static func componentType(post: Dictionary<String, String>, callback: @escaping (_ data: Any) -> Void){
        
        let postString = FirServices.user + POST.facility_component_type_id + "=" + post[POST.facility_component_type_id]!
        
        var listComponentType = [ComponentType]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_LIST_FACILITY_COMPONENT_TYPE, post: postString){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                print("JSON error!")
                return
            }
            for element in table{
                
                guard let id = element["FACILITY_COMPONENT_TYPE_ID"] as? String,
                    let name = element["FACILITY_COMPONENT_TYPE_NAME"] as? String,
                    let description = element["DESCRIPTION"] as? String
                    else{
                        print("Parsing JSON error!")
                        return
                }
                let componentType = ComponentType(componentTypeId: id, componentTypeName: name, description: description)
                listComponentType.append(componentType)
            }
            
            callback(listComponentType)
        }
    }
    // ============================
    
    
    // ============================
    private static func relationship(post: Dictionary<String, String>, callback: @escaping (_ data: Any) -> Void){
        
        let postString = FirServices.user + POST.facility_type_id + "=" + post[POST.facility_type_id]! + "&" + POST.facility_component_type_id + "=" + post[POST.facility_component_type_id]!
        
        var listRelationship = [Relationship]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_RELATIONSHIP, post: postString){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                print("JSON error!")
                return
            }
            for element in table{
                
                guard let facilityTypeId = element["FACILITY_TYPE_ID"] as? String,
                    let facilityTypeName = element["FACILITY_TYPE_NAME"] as? String,
                    let facilityComponentTypeId = element["FACILITY_COMPONENT_TYPE_ID"] as? String,
                    let facilityComponentTypeName = element["FACILITY_COMPONENT_TYPE_NAME"] as? String,
                    let fromDate = element["FROM_DATE"] as? String,
                    let thruDate = element["THRU_DATE"] as? String,
                    let note = element["NOTE"] as? String
                    else{
                        print("Parsing JSON error!")
                        return
                }
                let relationship = Relationship(
                    facilityTypeId: facilityTypeId,
                    facilityTypeName: facilityTypeName,
                    facilityComponentTypeId: facilityComponentTypeId,
                    facilityComponentTypeName: facilityComponentTypeName,
                    fromDate: fromDate,
                    thruDate: thruDate,
                    note: note
                )
                listRelationship.append(relationship)
            }
            
            callback(listRelationship)
        }
    }
    // ============================
    
}
