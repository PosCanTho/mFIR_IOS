//
//  ComponentType.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/24/17.
//  Copyright © 2017 Tống Thành Vinh. All rights reserved.
//

import Foundation

class ComponentType {
    let componentTypeId:String
    let componentTypeName:String
    let description:String
    
    init(componentTypeId:String, componentTypeName:String, description:String) {
        self.componentTypeId = componentTypeId
        self.componentTypeName = componentTypeName
        self.description = description
    }
}
