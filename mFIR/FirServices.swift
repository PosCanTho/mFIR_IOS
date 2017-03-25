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
            
        case .LOGIN:
            // post [imei] ---> imei có thể để trống ("")
            FirServices.login(post: post, callback: callback)
            break
            
        case .LIST_FACILITY:
            // post [facility_id] ---> facility_id=0: lấy tất cả
            FirServices.facility(post: post, callback: callback)
            break
            
        case .LIST_FACILITY_ISSUE:
            // post [facility_issue_id, from_date, thru_date] ---> facility_issue_id=0: lấy tất cả - theo from_date/thru_date
            FirServices.facilityIssue(post: post, callback: callback)
            break
            
        case .LIST_FACILITY_COMPONENT_TYPE:
            // post [facility_component_type_id] --> facility_component_type_id=0: lấy tất cả
            FirServices.componentType(post: post, callback: callback)
            break
            
        case .RELATIONSHIP:
            // post [facility_type_id, facility_component_type_id] ---> facility_type_id=0: lấy tất cả, facility_component_type_id=0: lấy tất cả
            FirServices.relationship(post: post, callback: callback)
            break
            
        case .LIST_FACILITY_TYPE:
            // post [facility_type_id] ---> facility_type_id=0: lấy tất cả
            FirServices.facilityType(post: post, callback: callback)
            break
            
        case .LIST_INSTRUCTOR:
            // post [instructor_id_number] ---> instructor_id_number="": lấy tất cả
            FirServices.instructor(post: post, callback: callback)
            break
            
        case .LIST_STUDENT:
            // post [student_id_number] ---> student_id_number="": lấy tất cả
            FirServices.student(post: post, callback: callback)
            break
            
        case .INSUPD_FACILITY_ISSUE:
            // FACILITY_ISSUE_ID=0: insert
            FirServices.updateIssue(post: post, callback: callback)
            break
            
        case .ISSUE_STATUS:
            FirServices.issueStatus(post: post, callback: callback)
            break
            
        case .ISSUE_BY_FACILITY:
            // post [facility_id] ---> facility_id=0: lấy tất cả
            FirServices.issueByFacility(post: post, callback: callback)
            break
            
        case .REGISTER_FCMTOKEN:
            break
            
        case .METHOD_FILE_FOR_FIR:
            break
            
        case .FILE_FOR_FIR:
            break
            
            
        }
    }
    // ============================
    
    
    // ============================
    private static func dataTask(
        url: String,
        post: String,
        callback: @escaping (_ json: Dictionary<String, Any>, _ error: String?) -> Void) {
        
        let TAG = "func -> dataTask: "
        
        let urlRequest = URL(string: url)!
        var request = URLRequest(url: urlRequest)
        
        request.httpMethod = "POST"
        request.httpBody = post.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil
                else {
                    print(TAG + "error=\(error)")
                    callback(Dictionary<String, AnyObject>(), error as! String?)
                    return
            }

            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200
            {
                print(TAG + "statusCode should be 200, but is \(httpStatus.statusCode)")
                print(TAG + "response = \(response)")
                
            }
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] {
                    callback(json, nil)
                }
                
            } catch let err{
                print(TAG + err.localizedDescription)
            }
        }
        task.resume()
    }
    // ============================
    
    
    // ============================
    private static func login(post: Dictionary<String, String>, callback: @escaping (_ data: Any) -> Void){
        
        let TAG = "func -> login: "
        
        guard let imei = post[POST.imei]
            else{
                print(TAG + "POST input error!")
                return
        }
        
        let postString = FirServices.user + POST.imei + "=" + imei
        
        FirServices.dataTask(url: Constants.URL.API_LOGIN, post: postString){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                print(TAG + "JSON error!")
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
                    print(TAG + "Parsing JSON error!")
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
        
        let TAG = "func -> facility: "
        
        guard let facility_id = post[POST.facility_id]
            else{
                print(TAG + "POST input error!")
                return
        }
        
        let postString = FirServices.user + POST.facility_id + "=" + facility_id
        
        var listFacility = [Facility]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_LIST_FACILITY, post: postString){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                print(TAG + "JSON error!")
                return
            }
            for element in table{
                
                guard let id = element["FACILITY_ID"] as? String,
                    let name = element["FACILITY_NAME"] as? String,
                    let typeName = element["FACILITY_TYPE_NAME"] as? String,
                    let usageStatus = element["FACILITY_USAGE_STATUS"] as? String,
                    let rootId = element["ROOT_ROOT_FACILITY_ID"] as? String
                    else{
                        print(TAG + "Parsing JSON error!")
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
        
        let TAG = "func -> facilityIssue: "
        
        guard let facility_issue_id = post[POST.facility_issue_id],
            let from_date = post[POST.from_date],
            let thru_date = post[POST.thru_date]
            else{
                print(TAG + "POST input error!")
                return
        }
        
        let postString = FirServices.user + POST.facility_issue_id + "=" + facility_issue_id + "&" + POST.from_date + "=" +  from_date + "&" + POST.thru_date + "=" + thru_date
        
        var listIssue = [Issue]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_LIST_FACILITY_ISSUE, post: postString){
            (json, error) in
            guard let table = json["Table"] as? [[String: Any]] else{
                print(TAG + "JSON error!")
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
                        print(TAG + "Parsing JSON error!")
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
        
        let TAG = "func -> componentType: "
        
        guard let facility_component_type_id = post[POST.facility_component_type_id]
            else{
                print(TAG + "POST input error!")
                return
        }
        
        let postString = FirServices.user + POST.facility_component_type_id + "=" + facility_component_type_id
        
        var listComponentType = [ComponentType]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_LIST_FACILITY_COMPONENT_TYPE, post: postString){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                print(TAG + "JSON error!")
                return
            }
            for element in table{
                
                guard let id = element["FACILITY_COMPONENT_TYPE_ID"] as? String,
                    let name = element["FACILITY_COMPONENT_TYPE_NAME"] as? String,
                    let description = element["DESCRIPTION"] as? String
                    else{
                        print(TAG + "Parsing JSON error!")
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
        
        let TAG = "func -> relationship: "
        
        guard let facility_type_id = post[POST.facility_type_id],
            let facility_component_type_id = post[POST.facility_component_type_id]
            else{
                print(TAG + "POST input error!")
                return
        }
        
        let postString = FirServices.user + POST.facility_type_id + "=" + facility_type_id + "&" + POST.facility_component_type_id + "=" + facility_component_type_id
        
        var listRelationship = [Relationship]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_RELATIONSHIP, post: postString){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                print(TAG + "JSON error!")
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
                        print(TAG + "Parsing JSON error!")
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
    
    
    // ============================
    private static func facilityType(post: Dictionary<String, String>, callback: @escaping (_ data: Any) -> Void){
        
        let TAG = "func -> facilityType: "
        
        guard let facility_type_id = post[POST.facility_type_id]
            else{
                print(TAG + "POST input error!")
                return
        }
        
        let postString = FirServices.user + POST.facility_type_id + "=" + facility_type_id
        
        var listFacilityType = [FacilityType]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_LIST_FACILITY_TYPE, post: postString){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                print(TAG + "JSON error!")
                return
            }
            for element in table{
                
                guard let id = element["FACILITY_TYPE_ID"] as? String,
                    let name = element["FACILITY_TYPE_NAME"] as? String,
                    let description = element["DESCRIPTION"] as? String
                    else{
                        print(TAG + "Parsing JSON error!")
                        return
                }
                let facilityType = FacilityType(facilityTypeId: id, facilityTypeName: name, desctiption: description)
                listFacilityType.append(facilityType)
                
            }
            
            callback(listFacilityType)
        }
    }
    // ============================
    
    
    // ============================
    private static func instructor(post: Dictionary<String, String>, callback: @escaping (_ data: Any) -> Void){
        
        let TAG = "func -> instructor: "
        
        guard let instructor_id_number = post[POST.instructor_id_number]
            else{
                print(TAG + "POST input error!")
                return
        }
        
        let postString = FirServices.user + POST.instructor_id_number + "=" + instructor_id_number
        
        var listInstructor = [Instructor]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_LIST_INSTRUCTOR, post: postString){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                print(TAG + "JSON error!")
                return
            }
            
            for element in table{
                
                guard let instructorIdNumber = element["INSTRUCTOR_ID_NUMBER"] as? String,
                    let currentLastName = element["CURRENT_LAST_NAME"] as? String,
                    let currentFirstName = element["CURRENT_FIRST_NAME"] as? String,
                    let currentMiddleName = element["CURRENT_MIDDLE_NAME"] as? String,
                    let currentPersonalTitle = element["CURRENT_PERSONAL_TITLE"] as? String,
                    let currentSuffix = element["CURRENT_SUFFIX"] as? String,
                    let currentNickname = element["CURRENT_NICKNAME"] as? String,
                    let birthDate = element["BIRTH_DATE"] as? String,
                    let birthPlace = element["BIRTH_PLACE"] as? String,
                    let motherSMaidenName = element["MOTHER_S_MAIDEN_NAME"] as? String,
                    let currentMaritalStatus = element["CURRENT_MARITAL_STATUS"] as? String,
                    let peopleIdNumber = element["PEOPLE_ID_NUMBER"] as? String,
                    let peopleIdIssueDate = element["PEOPLE_ID_ISSUE_DATE"] as? String,
                    let peopleIdIssuePlace = element["PEOPLE_ID_ISSUE_PLACE"] as? String,
                    let socialSecurityNumber = element["SOCIAL_SECURITY_NUMBER"] as? String,
                    let currentMajorCitizenship = element["CURRENT_MAJOR_CITIZENSHIP"] as? String,
                    let currentPassportNumber = element["CURRENT_PASSPORT_NUMBER"] as? String,
                    let currentPassportIssuePlace = element["CURRENT_PASSPORT_ISSUE_PLACE"] as? String,
                    let currentPassportIssueDate = element["CURRENT_PASSPORT_ISSUE_DATE"] as? String,
                    let currentPassportExpirationDate = element["CURRENT_PASSPORT_EXPIRATION_DATE"] as? String,
                    let totalYearsWorkExperience = element["TOTAL_YEARS_WORK_EXPERIENCE"] as? String,
                    let instructorTeachingStatusTypeName = element["INSTRUCTOR_TEACHING_STATUS_TYPE_NAME"] as? String,
                    let academicDepartment = element["ACADEMIC_DEPARTMENT"] as? String,
                    let academicGroupUnit = element["ACADEMIC_GROUP_UNIT"] as? String,
                    let academicTitle = element["ACADEMIC_TITLE"] as? String,
                    let instructorTypeName = element["INSTRUCTOR_TYPE_NAME"] as? String,
                    let closeupPicture1 = element["CLOSEUP_PICTURE_1"] as? String,
                    let closeupPicture2 = element["CLOSEUP_PICTURE_2"] as? String,
                    let currentAddress = element["CURRENT_ADDRESS"] as? String,
                    let currentCountry = element["CURRENT_COUNTRY"] as? String,
                    let currentDistrict = element["CURRENT_DISTRICT"] as? String,
                    let currentGender = element["CURRENT_GENDER"] as? String,
                    let currentState = element["CURRENT_STATE"] as? String,
                    let currentWard = element["CURRENT_WARD"] as? String,
                    let homeAddress = element["HOME_ADDRESS"] as? String,
                    let homeCity = element["HOME_CITY"] as? String,
                    let homeCountry = element["HOME_COUNTRY"] as? String,
                    let homeDistrict = element["HOME_DISTRICT"] as? String,
                    let homeState = element["HOME_STATE"] as? String,
                    let homeWard = element["HOME_WARD"] as? String,
                    let startDateInSchool = element["START_DATE_IN_SCHOOL"] as? String,
                    let startDateForTeaching = element["START_DATE_FOR_TEACHING"] as? String,
                    let startDateForTeachingInSchool = element["START_DATE_FOR_TEACHING_IN_SCHOOL"] as? String,
                    let currentPhoneNumber = element["CURRENT_PHONE_NUMBER"] as? String,
                    let currentMobileNumber = element["CURRENT_MOBILE_NUMBER"] as? String,
                    let currentPersonalEmail = element["CURRENT_PERSONAL_EMAIL"] as? String
                    else{
                        print(TAG + "Parsing JSON error!")
                        return
                }
                
                let instructor = Instructor(
                    instructorIdNumber: instructorIdNumber,
                    currentLastName: currentLastName,
                    currentFirstName: currentFirstName,
                    currentMiddleName: currentMiddleName,
                    currentPersonalTitle: currentPersonalTitle,
                    currentSuffix: currentSuffix,
                    currentNickname: currentNickname,
                    birthDate: birthDate,
                    birthPlace: birthPlace,
                    motherSMaidenName: motherSMaidenName,
                    currentMaritalStatus: currentMaritalStatus,
                    peopleIdNumber: peopleIdNumber,
                    peopleIdIssueDate: peopleIdIssueDate,
                    peopleIdIssuePlace: peopleIdIssuePlace,
                    socialSecurityNumber: socialSecurityNumber,
                    currentMajorCitizenship: currentMajorCitizenship,
                    currentPassportNumber: currentPassportNumber,
                    currentPassportIssuePlace: currentPassportIssuePlace,
                    currentPassportIssueDate: currentPassportIssueDate,
                    currentPassportExpirationDate: currentPassportExpirationDate,
                    totalYearsWorkExperience: totalYearsWorkExperience,
                    instructorTeachingStatusTypeName: instructorTeachingStatusTypeName,
                    academicDepartment: academicDepartment,
                    academicGroupUnit: academicGroupUnit,
                    academicTitle: academicTitle,
                    instructorTypeName: instructorTypeName,
                    closeupPicture1: closeupPicture1,
                    closeupPicture2: closeupPicture2,
                    currentAddress: currentAddress,
                    currentCountry: currentCountry,
                    currentDistrict: currentDistrict,
                    currentGender: currentGender,
                    currentState: currentState,
                    currentWard: currentWard,
                    homeAddress: homeAddress,
                    homeCity: homeCity,
                    homeCountry: homeCountry,
                    homeDistrict: homeDistrict,
                    homeState: homeState,
                    homeWard: homeWard,
                    startDateInSchool: startDateInSchool,
                    startDateForTeaching: startDateForTeaching,
                    startDateForTeachingInSchool: startDateForTeachingInSchool,
                    currentPhoneNumber: currentPhoneNumber,
                    currentMobileNumber: currentMobileNumber,
                    currentPersonalEmail: currentPersonalEmail
                )
                listInstructor.append(instructor)
                
            }
            
            callback(listInstructor)
        }
    }
    // ============================
    
    
    // ============================
    private static func student(post: Dictionary<String, String>, callback: @escaping (_ data: Any) -> Void){
        
        let TAG = "func -> student: "
        
        guard let student_id_number = post[POST.student_id_number]
            else{
                print(TAG + "POST input error!")
                return
        }
        
        let postString = FirServices.user + POST.student_id_number + "=" + student_id_number
        
        var listStudent = [Student]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_LIST_STUDENT, post: postString){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                print(TAG + "JSON error!")
                return
            }
            
            for element in table{
                
                guard let studentIdNumber = element["STUDENT_ID_NUMBER"] as? String,
                    let currentLastName = element["CURRENT_LAST_NAME"] as? String,
                    let currentFirstName = element["CURRENT_FIRST_NAME"] as? String,
                    let currentMiddleName = element["CURRENT_MIDDLE_NAME"] as? String,
                    let birthDate = element["BIRTH_DATE"] as? String,
                    let peopleIdNumber = element["PEOPLE_ID_NUMBER"] as? String,
                    let currentGender = element["CURRENT_GENDER"] as? String,
                    let currentPhoneNumber = element["CURRENT_PHONE_NUMBER"] as? String,
                    let currentMobileNumber = element["CURRENT_MOBILE_NUMBER"] as? String,
                    let academicIntakeSessionName = element["ACADEMIC_INTAKE_SESSION_NAME"] as? String,
                    let academicProgramName = element["ACADEMIC_PROGRAM_NAME"] as? String,
                    let curriculumName = element["CURRICULUM_NAME"] as? String,
                    let curriculumCode = element["CURRICULUM_CODE"] as? String,
                    let programShort = element["PROGRAM_SHORT"] as? String,
                    let academicProgramCode = element["ACADEMIC_PROGRAM_CODE"] as? String,
                    let academicLevelName = element["ACADEMIC_LEVEL_NAME"] as? String,
                    let studentLearningStatusTypeName = element["STUDENT_LEARNING_STATUS_TYPE_NAME"] as? String
                    else{
                        print(TAG + "Parsing JSON error!")
                        return
                }
                
                let student = Student(
                    studentIdNumber: studentIdNumber,
                    currentLastName: currentLastName,
                    currentFirstName: currentFirstName,
                    currentMiddleName: currentMiddleName,
                    birthDate: birthDate,
                    peopleIdNumber: peopleIdNumber,
                    currentGender: currentGender,
                    currentPhoneNumber: currentPhoneNumber,
                    currentMobileNumber: currentMobileNumber,
                    academicIntakeSessionName: academicIntakeSessionName,
                    academicProgramName: academicProgramName,
                    curriculumName: curriculumName,
                    curriculumCode: curriculumCode,
                    programShort: programShort,
                    academicProgramCode: academicProgramCode,
                    academicLevelName: academicLevelName,
                    studentLearningStatusTypeName: studentLearningStatusTypeName
                )
                listStudent.append(student)
                
            }
            
            callback(listStudent)
        }
    }
    // ============================
    
    
    // ============================
    private static func updateIssue(post: Dictionary<String, String>, callback: @escaping (_ data: Any) -> Void){
        
        let TAG = "func -> updateIssue: "
        
        guard let facilityIssueId = post[POST.FACILITY_ISSUE_ID],
            let facilityIssueCaseNumber = post[POST.FACILITY_ISSUE_CASE_NUMBER],
            let sameFacilityIssueId = post[POST.SAME_FACILITY_ISSUE_ID],
            let sameFacilityIssueCaseNumber = post[POST.SAME_FACILITY_ISSUE_CASE_NUMBER],
            let facilityIssueReportDatetime = post[POST.FACILITY_ISSUE_REPORT_DATETIME],
            let facilityIssueStatus = post[POST.FACILITY_ISSUE_STATUS],
            let instructorIdNumber = post[POST.INSTRUCTOR_ID_NUMBER],
            let studentIdNumber = post[POST.STUDENT_ID_NUMBER],
            let facilityId = post[POST.FACILITY_ID],
            let facilityName = post[POST.FACILITY_NAME],
            let facilityTypeName = post[POST.FACILITY_TYPE_NAME],
            let facilityComponentTypeId1 = post[POST.FACILITY_COMPONENT_TYPE_ID_1],
            let facilityComponentTypeName1 = post[POST.FACILITY_COMPONENT_TYPE_NAME_1],
            let facilityComponentIssueReport1 = post[POST.FACILITY_COMPONENT_ISSUE_REPORT_1],
            let facilityComponentIssueStatus1 = post[POST.FACILITY_COMPONENT_ISSUE_STATUS_1],
            let facilityComponentIssue_picture1 = post[POST.FACILITY_COMPONENT_ISSUE_PICTURE_1],
            let facilityIssueResolverIdNumber1 = post[POST.FACILITY_ISSUE_RESOLVER_ID_NUMBER_1],
            let facilityIssueResolvedDatetime1 = post[POST.FACILITY_ISSUE_RESOLVED_DATETIME_1],
            let facilityIssueResolversNote1 = post[POST.FACILITY_ISSUE_RESOLVERS_NOTE_1],
            let facilityComponentTypeId2 = post[POST.FACILITY_COMPONENT_TYPE_ID_2],
            let facilityComponentTypeName2 = post[POST.FACILITY_COMPONENT_TYPE_NAME_2],
            let facilityComponentIssueReport2 = post[POST.FACILITY_COMPONENT_ISSUE_REPORT_2],
            let facilityComponentIssueStatus2 = post[POST.FACILITY_COMPONENT_ISSUE_STATUS_2],
            let facilityComponentIssue_picture2 = post[POST.FACILITY_COMPONENT_ISSUE_PICTURE_2],
            let facilityIssueResolverIdNumber2 = post[POST.FACILITY_ISSUE_RESOLVER_ID_NUMBER_2],
            let facilityIssueResolvedDatetime2 = post[POST.FACILITY_ISSUE_RESOLVED_DATETIME_2],
            let facilityIssueResolversNote2 = post[POST.FACILITY_ISSUE_RESOLVERS_NOTE_2],
            let facilityComponentTypeId3 = post[POST.FACILITY_COMPONENT_TYPE_ID_3],
            let facilityComponentTypeName3 = post[POST.FACILITY_COMPONENT_TYPE_NAME_3],
            let facilityComponentIssueReport3 = post[POST.FACILITY_COMPONENT_ISSUE_REPORT_3],
            let facilityComponentIssueStatus3 = post[POST.FACILITY_COMPONENT_ISSUE_STATUS_3],
            let facilityComponentIssue_picture3 = post[POST.FACILITY_COMPONENT_ISSUE_PICTURE_3],
            let facilityIssueResolverIdNumber3 = post[POST.FACILITY_ISSUE_RESOLVER_ID_NUMBER_3],
            let facilityIssueResolvedDatetime3 = post[POST.FACILITY_ISSUE_RESOLVED_DATETIME_3],
            let facilityIssueResolversNote3 = post[POST.FACILITY_ISSUE_RESOLVERS_NOTE_3],
            let facilityComponentTypeId4 = post[POST.FACILITY_COMPONENT_TYPE_ID_4],
            let facilityComponentTypeName4 = post[POST.FACILITY_COMPONENT_TYPE_NAME_4],
            let facilityComponentIssueReport4 = post[POST.FACILITY_COMPONENT_ISSUE_REPORT_4],
            let facilityComponentIssueStatus4 = post[POST.FACILITY_COMPONENT_ISSUE_STATUS_4],
            let facilityComponentIssue_picture4 = post[POST.FACILITY_COMPONENT_ISSUE_PICTURE_4],
            let facilityIssueResolverIdNumber4 = post[POST.FACILITY_ISSUE_RESOLVER_ID_NUMBER_4],
            let facilityIssueResolvedDatetime4 = post[POST.FACILITY_ISSUE_RESOLVED_DATETIME_4],
            let facilityIssueResolversNote4 = post[POST.FACILITY_ISSUE_RESOLVERS_NOTE_4],
            let facilityComponentTypeId5 = post[POST.FACILITY_COMPONENT_TYPE_ID_5],
            let facilityComponentTypeName5 = post[POST.FACILITY_COMPONENT_TYPE_NAME_5],
            let facilityComponentIssueReport5 = post[POST.FACILITY_COMPONENT_ISSUE_REPORT_5],
            let facilityComponentIssueStatus5 = post[POST.FACILITY_COMPONENT_ISSUE_STATUS_5],
            let facilityComponentIssue_picture5 = post[POST.FACILITY_COMPONENT_ISSUE_PICTURE_5],
            let facilityIssueResolverIdNumber5 = post[POST.FACILITY_ISSUE_RESOLVER_ID_NUMBER_5],
            let facilityIssueResolvedDatetime5 = post[POST.FACILITY_ISSUE_RESOLVED_DATETIME_5],
            let facilityIssueResolversNote5 = post[POST.FACILITY_ISSUE_RESOLVERS_NOTE_5]
            else{
                print(TAG + "POST input error!")
                return
        }
        
        let postString = FirServices.user
            + POST.FACILITY_ISSUE_ID + "=" + facilityIssueId + "&"
            + POST.FACILITY_ISSUE_CASE_NUMBER + "=" + facilityIssueCaseNumber + "&"
            + POST.SAME_FACILITY_ISSUE_ID + "=" + sameFacilityIssueId + "&"
            + POST.SAME_FACILITY_ISSUE_CASE_NUMBER + "=" + sameFacilityIssueCaseNumber + "&"
            + POST.FACILITY_ISSUE_REPORT_DATETIME + "=" + facilityIssueReportDatetime + "&"
            + POST.FACILITY_ISSUE_STATUS + "=" + facilityIssueStatus + "&"
            + POST.INSTRUCTOR_ID_NUMBER + "=" + instructorIdNumber + "&"
            + POST.STUDENT_ID_NUMBER + "=" + studentIdNumber + "&"
            + POST.FACILITY_ID + "=" + facilityId + "&"
            + POST.FACILITY_NAME + "=" + facilityName + "&"
            + POST.FACILITY_TYPE_NAME + "=" + facilityTypeName + "&"
            + POST.FACILITY_COMPONENT_TYPE_ID_1 + "=" + facilityComponentTypeId1 + "&"
            + POST.FACILITY_COMPONENT_TYPE_NAME_1 + "=" + facilityComponentTypeName1 + "&"
            + POST.FACILITY_COMPONENT_ISSUE_REPORT_1 + "=" + facilityComponentIssueReport1 + "&"
            + POST.FACILITY_COMPONENT_ISSUE_STATUS_1 + "=" + facilityComponentIssueStatus1 + "&"
            + POST.FACILITY_COMPONENT_ISSUE_PICTURE_1 + "=" + facilityComponentIssue_picture1 + "&"
            + POST.FACILITY_ISSUE_RESOLVER_ID_NUMBER_1 + "=" + facilityIssueResolverIdNumber1 + "&"
            + POST.FACILITY_ISSUE_RESOLVED_DATETIME_1 + "=" + facilityIssueResolvedDatetime1 + "&"
            + POST.FACILITY_ISSUE_RESOLVERS_NOTE_1 + "=" + facilityIssueResolversNote1 + "&"
            + POST.FACILITY_COMPONENT_TYPE_ID_2 + "=" + facilityComponentTypeId2 + "&"
            + POST.FACILITY_COMPONENT_TYPE_NAME_2 + "=" + facilityComponentTypeName2 + "&"
            + POST.FACILITY_COMPONENT_ISSUE_REPORT_2 + "=" + facilityComponentIssueReport2 + "&"
            + POST.FACILITY_COMPONENT_ISSUE_STATUS_2 + "=" + facilityComponentIssueStatus2 + "&"
            + POST.FACILITY_COMPONENT_ISSUE_PICTURE_2 + "=" + facilityComponentIssue_picture2 + "&"
            + POST.FACILITY_ISSUE_RESOLVER_ID_NUMBER_2 + "=" + facilityIssueResolverIdNumber2 + "&"
            + POST.FACILITY_ISSUE_RESOLVED_DATETIME_2 + "=" + facilityIssueResolvedDatetime2 + "&"
            + POST.FACILITY_ISSUE_RESOLVERS_NOTE_2 + "=" + facilityIssueResolversNote2 + "&"
            + POST.FACILITY_COMPONENT_TYPE_ID_3 + "=" + facilityComponentTypeId3 + "&"
            + POST.FACILITY_COMPONENT_TYPE_NAME_3 + "=" + facilityComponentTypeName3 + "&"
            + POST.FACILITY_COMPONENT_ISSUE_REPORT_3 + "=" + facilityComponentIssueReport3 + "&"
            + POST.FACILITY_COMPONENT_ISSUE_STATUS_3 + "=" + facilityComponentIssueStatus3 + "&"
            + POST.FACILITY_COMPONENT_ISSUE_PICTURE_3 + "=" + facilityComponentIssue_picture3 + "&"
            + POST.FACILITY_ISSUE_RESOLVER_ID_NUMBER_3 + "=" + facilityIssueResolverIdNumber3 + "&"
            + POST.FACILITY_ISSUE_RESOLVED_DATETIME_3 + "=" + facilityIssueResolvedDatetime3 + "&"
            + POST.FACILITY_ISSUE_RESOLVERS_NOTE_3 + "=" + facilityIssueResolversNote3 + "&"
            + POST.FACILITY_COMPONENT_TYPE_ID_4 + "=" + facilityComponentTypeId4 + "&"
            + POST.FACILITY_COMPONENT_TYPE_NAME_4 + "=" + facilityComponentTypeName4 + "&"
            + POST.FACILITY_COMPONENT_ISSUE_REPORT_4 + "=" + facilityComponentIssueReport4 + "&"
            + POST.FACILITY_COMPONENT_ISSUE_STATUS_4 + "=" + facilityComponentIssueStatus4 + "&"
            + POST.FACILITY_COMPONENT_ISSUE_PICTURE_4 + "=" + facilityComponentIssue_picture4 + "&"
            + POST.FACILITY_ISSUE_RESOLVER_ID_NUMBER_4 + "=" + facilityIssueResolverIdNumber4 + "&"
            + POST.FACILITY_ISSUE_RESOLVED_DATETIME_4 + "=" + facilityIssueResolvedDatetime4 + "&"
            + POST.FACILITY_ISSUE_RESOLVERS_NOTE_4 + "=" + facilityIssueResolversNote4 + "&"
            + POST.FACILITY_COMPONENT_TYPE_ID_5 + "=" + facilityComponentTypeId5 + "&"
            + POST.FACILITY_COMPONENT_TYPE_NAME_5 + "=" + facilityComponentTypeName5 + "&"
            + POST.FACILITY_COMPONENT_ISSUE_REPORT_5 + "=" + facilityComponentIssueReport5 + "&"
            + POST.FACILITY_COMPONENT_ISSUE_STATUS_5 + "=" + facilityComponentIssueStatus5 + "&"
            + POST.FACILITY_COMPONENT_ISSUE_PICTURE_5 + "=" + facilityComponentIssue_picture5 + "&"
            + POST.FACILITY_ISSUE_RESOLVER_ID_NUMBER_5 + "=" + facilityIssueResolverIdNumber5 + "&"
            + POST.FACILITY_ISSUE_RESOLVED_DATETIME_5 + "=" + facilityIssueResolvedDatetime5 + "&"
            + POST.FACILITY_ISSUE_RESOLVERS_NOTE_5 + "=" + facilityIssueResolversNote5
        
        FirServices.dataTask(url: Constants.URL.API_UPDATE_FACILITY_ISSUE, post: postString){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                print(TAG + "JSON error!")
                return
            }
            
            print(table)
            
            callback("TEST THU")
        }
    }
    // ============================
    
    
    // ============================
    private static func issueStatus(post: Dictionary<String, String>, callback: @escaping (_ data: Any) -> Void){
        
        let TAG = "func -> issueStatus: "
        
        let postString = FirServices.user
        
        var listIssueStatus = [IssueStatus]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_ISSUE_STATUS, post: postString){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                print(TAG + "JSON error!")
                return
            }
            for element in table{
                
                guard let id = element["TYPE_NAME_ID"] as? String,
                    let name = element["TYPE_NAME_NAME"] as? String
                    else{
                        print(TAG + "Parsing JSON error!")
                        return
                }
                let issueStatus = IssueStatus(typeNameId: id, typeNameName: name)
                listIssueStatus.append(issueStatus)
                
            }
            
            callback(listIssueStatus)
        }
    }
    // ============================
    
    // ============================
    private static func issueByFacility(post: Dictionary<String, String>, callback: @escaping (_ data: Any) -> Void){
        
        let TAG = "func -> issueByFacility: "
        
        guard let facility_id = post[POST.facility_id]
            else{
                print(TAG + "POST input error!")
                return
        }
        
        let postString = FirServices.user + POST.facility_id + "=" + facility_id
        
        var listIssue = [Issue]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_ISSUE_BY_FACILITY, post: postString){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                print(TAG + "JSON error!")
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
                        print(TAG + "Parsing JSON error!")
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
}
