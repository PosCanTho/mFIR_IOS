//
//  FacilityRelationshipData.swift
//  mFIR
//
//  Created by Baslor on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class FacilityRelationshipData{
    // var listFacilityData: Array<FacilityData> = Array()
    
    func insertAllFacilityRelationship( listFacilityRelationshipData: Array<Relationship> = Array()){
        var results : NSArray?
        let appDel: AppDelegate =  UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        // INSERT
        let facilityRelationshipData = NSEntityDescription.insertNewObject(forEntityName: Databases.TABLE_FACILITY_RELATIONSHIP, into:  context)
        facilityRelationshipData.setValue("234", forKey: Databases.FACILITY_TYPE_ID)
        facilityRelationshipData.setValue("phong thuc hanh", forKey: Databases.FACILITY_TYPE_NAME)
        facilityRelationshipData.setValue("pham thi nguyet hue", forKey: Databases.FACILITY_COMPONENT_TYPE_ID)
        facilityRelationshipData.setValue("234", forKey: Databases.FACILITY_COMPONENT_TYPE_NAME)
        facilityRelationshipData.setValue("phong thuc hanh", forKey: Databases.FROM_DATE)
        facilityRelationshipData.setValue("pham thi nguyet hue", forKey: Databases.THRU_DATE)
        facilityRelationshipData.setValue("pham thi nguyet hue", forKey: Databases.NOTE)
        
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
