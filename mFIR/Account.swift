//
//  Account.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/24/17.
//  Copyright © 2017 Tống Thành Vinh. All rights reserved.
//

import Foundation

class Account {
    
    let userId:String
    let userName:String
    let studentIdNumber:String
    let instructorIdNumber:String
    let currentLastName:String
    let currentMiddleName:String
    let currentFirstName:String
    let roleType:String
    
    init(
        userId:String,
        userName:String,
        studentIdNumber:String,
        instructorIdNumber:String,
        currentLastName:String,
        currentMiddleName:String,
        currentFirstName:String,
        roleType:String) {
        
        self.instructorIdNumber = instructorIdNumber
        self.userName = userName
        self.currentLastName = currentLastName
        self.roleType = roleType
        self.studentIdNumber = studentIdNumber
        self.currentFirstName = currentFirstName
        self.userId = userId
        self.currentMiddleName = currentMiddleName
        
    }
}
