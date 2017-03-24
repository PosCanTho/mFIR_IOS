//
//  Relationship.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/24/17.
//  Copyright © 2017 Tống Thành Vinh. All rights reserved.
//

import Foundation

class Relationship{
    
    let facilityTypeId:String
    let facilityTypeName:String
    let facilityComponentTypeId:String
    let facilityComponentTypeName:String
    let fromDate:String
    let thruDate:String
    let note:String
    
    init(
        facilityTypeId:String,
        facilityTypeName:String,
        facilityComponentTypeId:String,
        facilityComponentTypeName:String,
        fromDate:String,
        thruDate:String,
        note:String
        ){
        self.facilityTypeId = facilityTypeId
        self.facilityTypeName = facilityTypeName
        self.facilityComponentTypeId = facilityComponentTypeId
        self.facilityComponentTypeName = facilityComponentTypeName
        self.fromDate = fromDate
        self.thruDate = thruDate
        self.note = note
    }
}
