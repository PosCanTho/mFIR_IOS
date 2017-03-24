//
//  Student.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation

class Student {
    let studentIdNumber:String
    let currentLastName:String
    let currentFirstName:String
    let currentMiddleName:String
    let birthDate:String
    let peopleIdNumber:String
    let currentGender:String
    let currentPhoneNumber:String
    let currentMobileNumber:String
    let academicIntakeSessionName:String
    let academicProgramName:String
    let curriculumName:String
    let curriculumCode:String
    let programShort:String
    let academicProgramCode:String
    let academicLevelName:String
    let studentLearningStatusTypeName:String
    
    init(
        studentIdNumber:String,
        currentLastName:String,
        currentFirstName:String,
        currentMiddleName:String,
        birthDate:String,
        peopleIdNumber:String,
        currentGender:String,
        currentPhoneNumber:String,
        currentMobileNumber:String,
        academicIntakeSessionName:String,
        academicProgramName:String,
        curriculumName:String,
        curriculumCode:String,
        programShort:String,
        academicProgramCode:String,
        academicLevelName:String,
        studentLearningStatusTypeName:String
        ){
        self.studentIdNumber = studentIdNumber
        self.currentLastName = currentLastName
        self.currentFirstName = currentFirstName
        self.currentMiddleName = currentMiddleName
        self.birthDate = birthDate
        self.peopleIdNumber = peopleIdNumber
        self.currentGender = currentGender
        self.currentPhoneNumber = currentPhoneNumber
        self.currentMobileNumber = currentMobileNumber
        self.academicIntakeSessionName = academicIntakeSessionName
        self.academicProgramName = academicProgramName
        self.curriculumName = curriculumName
        self.curriculumCode = curriculumCode
        self.programShort = programShort
        self.academicProgramCode = academicProgramCode
        self.academicLevelName = academicLevelName
        self.studentLearningStatusTypeName = studentLearningStatusTypeName
    }
}
