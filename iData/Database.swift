//
//  Database.swift
//  iData
//
//  Created by Sushil Dahal on 4/14/16.
//  Copyright © 2016 Sushil Dahal. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Database{
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext: NSManagedObjectContext
    
    init(){
        managedObjectContext = appDelegate.managedObjectContext
    }
    
    func createNewPerson(){
        // Create Managed Object
        let entityDescription: NSEntityDescription = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedObjectContext)!
        let newPerson: NSManagedObject = NSManagedObject(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        
        // Configure New Person
        newPerson.setValue("Sushil", forKey: "first")
        newPerson.setValue("Dahal", forKey: "last")
        newPerson.setValue(26, forKey: "age")
        
        //Save New Person
        do {
            try newPerson.managedObjectContext?.save()
        } catch let error as NSError{
            print("Error: \(error.localizedDescription)")
        }
    }
}