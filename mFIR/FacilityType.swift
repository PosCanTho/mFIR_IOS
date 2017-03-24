//
//  FacilityType.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/24/17.
//  Copyright © 2017 Tống Thành Vinh. All rights reserved.
//

import Foundation

class FacilityType {
    let facilityTypeId:String
    let facilityTypeName:String
    let desctiption:String
    
    init(facilityTypeId:String, facilityTypeName:String, desctiption:String) {
        self.facilityTypeId = facilityTypeId
        self.facilityTypeName = facilityTypeName
        self.desctiption = desctiption
    }
}
