//
//  FacilityComponentTypeData.swift
//  mFIR
//
//  Created by Baslor on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//
import Foundation
import CoreData
import UIKit
class FacilityComponentTypeData{
    // var listFacilityData: Array<FacilityData> = Array()
    
    func insertAllFacilityComponentType( listFacilityComponentTypeData: Array<ComponentType> = Array()){
        var results : NSArray?
        let appDel: AppDelegate =  UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        // INSERT
        let facilityComponentTypeData = NSEntityDescription.insertNewObject(forEntityName: Databases.TABLE_FACILITY_COMPONENT_TYPE, into:  context)
        facilityComponentTypeData.setValue("234", forKey: Databases.FACILITY_COMPONENT_TYPE_ID)
        facilityComponentTypeData.setValue("phong thuc hanh", forKey: Databases.FACILITY_COMPONENT_TYPE_NAME)
        facilityComponentTypeData.setValue("pham thi nguyet hue", forKey: Databases.DESCRIPTION)
        do {
            try context.save()
            print("thanh cong")
        }
        catch {
            print("Error!")
        }
        
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: Databases.TABLE_FACILITY_COMPONENT_TYPE)
        request.returnsObjectsAsFaults = false
        results = try! context.fetch(request) as NSArray?
        
        if (results!.count>0){
            for res in results! {
                print(res)
            }
        }
        
    }
}
