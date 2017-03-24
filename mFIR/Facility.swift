//
//  Facility.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/23/17.
//  Copyright © 2017 Tống Thành Vinh. All rights reserved.
//

import Foundation

class Facility {
    
    let id:String
    let name:String
    let typeName:String
    let usageStatus:String
    let rootId:String
    
    init(id: String, name: String, typeName: String, usageStatus: String, rootId: String) {
        self.id = id
        self.name = name
        self.typeName = typeName
        self.usageStatus = usageStatus
        self.rootId = rootId
    }
}
