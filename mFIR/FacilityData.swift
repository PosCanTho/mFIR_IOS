//
//  FacilityData.swift
//  mFIR
//
//  Created by Baslor on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class FacilityData{
   // var listFacilityData: Array<FacilityData> = Array()
    func insertFacility( FacilityData: Facility){
        var results : NSArray?
        let appDel: AppDelegate =  UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        // INSERT
        let facilityData = NSEntityDescription.insertNewObject(forEntityName: Databases.TABLE_FACILITY, into:  context)
        facilityData.setValue("234", forKey: Databases.FACILITY_ID)
        facilityData.setValue("phong thuc hanh", forKey: Databases.FACILITY_NAME)
        facilityData.setValue("pham thi nguyet hue", forKey: Databases.FACILITY_TYPE_NAME)
        facilityData.setValue("phong thuc hanh", forKey: Databases.ROOT_FACILITY_ID)
        facilityData.setValue("pham thi nguyet hue", forKey: Databases.FACILITY_USAGE_STATUS)
        do {
            try context.save()
            print("insert facility thanh cong!")
        }
        catch {
            print("Error!")
        }
        
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: Databases.TABLE_FACILITY)
        request.returnsObjectsAsFaults = false
        results = try! context.fetch(request) as NSArray?
        
        if (results!.count>0){
            for res in results! {
                print(res)
            }
        }
        

    
    func insertAllFacility( listFacilityData: Array<Facility> = Array()){
         var results : NSArray?
        let appDel: AppDelegate =  UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        // INSERT
        let facilityData = NSEntityDescription.insertNewObject(forEntityName: Databases.TABLE_FACILITY, into:  context)
        facilityData.setValue("234", forKey: Databases.FACILITY_ID)
        facilityData.setValue("phong thuc hanh", forKey: Databases.FACILITY_NAME)
        facilityData.setValue("pham thi nguyet hue", forKey: Databases.FACILITY_TYPE_NAME)
        facilityData.setValue("phong thuc hanh", forKey: Databases.ROOT_FACILITY_ID)
        facilityData.setValue("pham thi nguyet hue", forKey: Databases.FACILITY_USAGE_STATUS)
        do {
            try context.save()
            print("insert facility thanh cong!")
        }
        catch {
            print("Error!")
        }
        
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: Databases.TABLE_FACILITY)
        request.returnsObjectsAsFaults = false
        results = try! context.fetch(request) as NSArray?
        
        if (results!.count>0){
            for res in results! {
                print(res)
            }
        }

}
}
