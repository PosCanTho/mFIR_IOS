//
//  FacilityTypeData.swift
//  mFIR
//
//  Created by Baslor on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class FacilityTypeData{
    // var listFacilityData: Array<FacilityData> = Array()
    
    func insertAllFacilityType( listFacilityTypeData: Array<FacilityType> = Array()){
        var results : NSArray?
        let appDel: AppDelegate =  UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        // INSERT
        let facilityTypeData = NSEntityDescription.insertNewObject(forEntityName: Databases.TABLE_FACILITY_TYPE, into:  context)
        facilityTypeData.setValue("234", forKey: Databases.FACILITY_TYPE_ID)
        facilityTypeData.setValue("phong thuc hanh", forKey: Databases.FACILITY_TYPE_NAME)
        facilityTypeData.setValue("pham thi nguyet hue", forKey: Databases.DESCRIPTION)
        do {
            try context.save()
            print("thanh cong")
        }
        catch {
            print("Error!")
        }
        
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: Databases.TABLE_FACILITY_TYPE)
        request.returnsObjectsAsFaults = false
        results = try! context.fetch(request) as NSArray?
        
        if (results!.count>0){
            for res in results! {
                print(res)
            }
        }
        
    }
}
