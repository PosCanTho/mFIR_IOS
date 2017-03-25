//
//  Facility.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/23/17.
//  Copyright © 2017 Tống Thành Vinh. All rights reserved.
//

import Foundation

class Facility {
    
    var id:String
    var name:String
    var typeName:String
    var usageStatus:String
    var rootId:String
    
    init(id: String, name: String, typeName: String, usageStatus: String, rootId: String) {
        self.id = id
        self.name = name
        self.typeName = typeName
        self.usageStatus = usageStatus
        self.rootId = rootId
    }
}
