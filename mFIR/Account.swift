//
//  Account.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/24/17.
//  Copyright © 2017 Tống Thành Vinh. All rights reserved.
//

import Foundation

class Account {
    
    var userId:String
    var userName:String
    var studentIdNumber:String
    var instructorIdNumber:String
    var currentLastName:String
    var currentMiddleName:String
    var currentFirstName:String
    var rovarype:String
    
    init(
        userId:String,
        userName:String,
        studentIdNumber:String,
        instructorIdNumber:String,
        currentLastName:String,
        currentMiddleName:String,
        currentFirstName:String,
        rovarype:String) {
        
        self.instructorIdNumber = instructorIdNumber
        self.userName = userName
        self.currentLastName = currentLastName
        self.rovarype = rovarype
        self.studentIdNumber = studentIdNumber
        self.currentFirstName = currentFirstName
        self.userId = userId
        self.currentMiddleName = currentMiddleName
        
    }
}
