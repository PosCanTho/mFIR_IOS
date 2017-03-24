//
//  Issue.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/24/17.
//  Copyright © 2017 Tống Thành Vinh. All rights reserved.
//

import Foundation

class Issue{
    
    let facilityIssueId:String?
    let facilityIssueCaseNumber:String?
    let sameFacilityIssueId:String?
    let sameFacilityIssueCaseNumber:String?
    let facilityIssueReportDatetime:String?
    let facilityIssueStatus:String?
    let instructorIdNumber:String?
    let studentIdNumber:String?
    let facilityId:String?
    let facilityName:String?
    let facilityTypeName:String?
    let facilityComponentTypeId1:String?
    let facilityComponentTypeName1:String?
    let facilityComponentIssueReport1:String?
    let facilityComponentIssueStatus1:String?
    let facilityComponentIssue_picture1:String?
    let facilityIssueResolverIdNumber1:String?
    let facilityIssueResolvedDatetime1:String?
    let facilityIssueResolversNote1:String?
    let facilityComponentTypeId2:String?
    let facilityComponentTypeName2:String?
    let facilityComponentIssueReport2:String?
    let facilityComponentIssueStatus2:String?
    let facilityComponentIssue_picture2:String?
    let facilityIssueResolverIdNumber2:String?
    let facilityIssueResolvedDatetime2:String?
    let facilityIssueResolversNote2:String?
    let facilityComponentTypeId3:String?
    let facilityComponentTypeName3:String?
    let facilityComponentIssueReport3:String?
    let facilityComponentIssueStatus3:String?
    let facilityComponentIssue_picture3:String?
    let facilityIssueResolverIdNumber3:String?
    let facilityIssueResolvedDatetime3:String?
    let facilityIssueResolversNote3:String?
    let facilityComponentTypeId4:String?
    let facilityComponentTypeName4:String?
    let facilityComponentIssueReport4:String?
    let facilityComponentIssueStatus4:String?
    let facilityComponentIssue_picture4:String?
    let facilityIssueResolverIdNumber4:String?
    let facilityIssueResolvedDatetime4:String?
    let facilityIssueResolversNote4:String?
    let facilityComponentTypeId5:String?
    let facilityComponentTypeName5:String?
    let facilityComponentIssueReport5:String?
    let facilityComponentIssueStatus5:String?
    let facilityComponentIssue_picture5:String?
    let facilityIssueResolverIdNumber5:String?
    let facilityIssueResolvedDatetime5:String?
    let facilityIssueResolversNote5:String?
    
    init(
        facilityIssueId: String,
        facilityIssueCaseNumber: String,
        sameFacilityIssueId: String,
        sameFacilityIssueCaseNumber: String,
        facilityIssueReportDatetime: String,
        facilityIssueStatus: String,
        instructorIdNumber: String,
        studentIdNumber: String,
        facilityId: String,
        facilityName: String,
        facilityTypeName: String,
        facilityComponentTypeId1: String,
        facilityComponentTypeName1: String,
        facilityComponentIssueReport1: String,
        facilityComponentIssueStatus1: String,
        facilityComponentIssue_picture1: String,
        facilityIssueResolverIdNumber1: String,
        facilityIssueResolvedDatetime1: String,
        facilityIssueResolversNote1: String,
        facilityComponentTypeId2: String,
        facilityComponentTypeName2: String,
        facilityComponentIssueReport2: String,
        facilityComponentIssueStatus2: String,
        facilityComponentIssue_picture2: String,
        facilityIssueResolverIdNumber2: String,
        facilityIssueResolvedDatetime2: String,
        facilityIssueResolversNote2: String,
        facilityComponentTypeId3: String,
        facilityComponentTypeName3: String,
        facilityComponentIssueReport3: String,
        facilityComponentIssueStatus3: String,
        facilityComponentIssue_picture3: String,
        facilityIssueResolverIdNumber3: String,
        facilityIssueResolvedDatetime3: String,
        facilityIssueResolversNote3: String,
        facilityComponentTypeId4: String,
        facilityComponentTypeName4: String,
        facilityComponentIssueReport4: String,
        facilityComponentIssueStatus4: String,
        facilityComponentIssue_picture4: String,
        facilityIssueResolverIdNumber4: String,
        facilityIssueResolvedDatetime4: String,
        facilityIssueResolversNote4: String,
        facilityComponentTypeId5: String,
        facilityComponentTypeName5: String,
        facilityComponentIssueReport5: String,
        facilityComponentIssueStatus5: String,
        facilityComponentIssue_picture5: String,
        facilityIssueResolverIdNumber5: String,
        facilityIssueResolvedDatetime5: String,
        facilityIssueResolversNote5: String
        ) {
        self.facilityIssueId = facilityIssueId
        self.facilityIssueCaseNumber = facilityIssueCaseNumber
        self.sameFacilityIssueId = sameFacilityIssueId
        self.sameFacilityIssueCaseNumber = sameFacilityIssueCaseNumber
        self.facilityIssueReportDatetime = facilityIssueReportDatetime
        self.facilityIssueStatus = facilityIssueStatus
        self.instructorIdNumber = instructorIdNumber
        self.studentIdNumber = studentIdNumber
        self.facilityId = facilityId
        self.facilityName = facilityName
        self.facilityTypeName = facilityTypeName
        self.facilityComponentTypeId1 = facilityComponentTypeId1
        self.facilityComponentTypeName1 = facilityComponentTypeName1
        self.facilityComponentIssueReport1 = facilityComponentIssueReport1
        self.facilityComponentIssueStatus1 = facilityComponentIssueStatus1
        self.facilityComponentIssue_picture1 = facilityComponentIssue_picture1
        self.facilityIssueResolverIdNumber1 = facilityIssueResolverIdNumber1
        self.facilityIssueResolvedDatetime1 = facilityIssueResolvedDatetime1
        self.facilityIssueResolversNote1 = facilityIssueResolversNote1
        self.facilityComponentTypeId2 = facilityComponentTypeId2
        self.facilityComponentTypeName2 = facilityComponentTypeName2
        self.facilityComponentIssueReport2 = facilityComponentIssueReport2
        self.facilityComponentIssueStatus2 = facilityComponentIssueStatus2
        self.facilityComponentIssue_picture2 = facilityComponentIssue_picture2
        self.facilityIssueResolverIdNumber2 = facilityIssueResolverIdNumber2
        self.facilityIssueResolvedDatetime2 = facilityIssueResolvedDatetime2
        self.facilityIssueResolversNote2 = facilityIssueResolversNote2
        self.facilityComponentTypeId3 = facilityComponentTypeId3
        self.facilityComponentTypeName3 = facilityComponentTypeName3
        self.facilityComponentIssueReport3 = facilityComponentIssueReport3
        self.facilityComponentIssueStatus3 = facilityComponentIssueStatus3
        self.facilityComponentIssue_picture3 = facilityComponentIssue_picture3
        self.facilityIssueResolverIdNumber3 = facilityIssueResolverIdNumber3
        self.facilityIssueResolvedDatetime3 = facilityIssueResolvedDatetime3
        self.facilityIssueResolversNote3 = facilityIssueResolversNote3
        self.facilityComponentTypeId4 = facilityComponentTypeId4
        self.facilityComponentTypeName4 = facilityComponentTypeName4
        self.facilityComponentIssueReport4 = facilityComponentIssueReport4
        self.facilityComponentIssueStatus4 = facilityComponentIssueStatus4
        self.facilityComponentIssue_picture4 = facilityComponentIssue_picture4
        self.facilityIssueResolverIdNumber4 = facilityIssueResolverIdNumber4
        self.facilityIssueResolvedDatetime4 = facilityIssueResolvedDatetime4
        self.facilityIssueResolversNote4 = facilityIssueResolversNote4
        self.facilityComponentTypeId5 = facilityComponentTypeId5
        self.facilityComponentTypeName5 = facilityComponentTypeName5
        self.facilityComponentIssueReport5 = facilityComponentIssueReport5
        self.facilityComponentIssueStatus5 = facilityComponentIssueStatus5
        self.facilityComponentIssue_picture5 = facilityComponentIssue_picture5
        self.facilityIssueResolverIdNumber5 = facilityIssueResolverIdNumber5
        self.facilityIssueResolvedDatetime5 = facilityIssueResolvedDatetime5
        self.facilityIssueResolversNote5 = facilityIssueResolversNote5
    }
}
