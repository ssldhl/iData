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
    
    func createNewPerson()->NSManagedObject{
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
        return newPerson
    }
    
    func getAllPersons()->[NSManagedObject]{
        // Initialize Fetch Request
        let fetchRequest: NSFetchRequest = NSFetchRequest()
        
        // Create Entity Description
        let entityDescription: NSEntityDescription = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedObjectContext)!
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        var persons: [NSManagedObject] = []
        
        do {
            let result: [AnyObject] = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            if (result.count > 0) {
                persons = result as! [NSManagedObject]
                
                for person in persons{
                    if let first = person.valueForKey("first"), last = person.valueForKey("last"), age = person.valueForKey("age") {
                        print("First: \(first) | Last: \(last) | Age: \(age)")
                    }
                }
            }
            
        } catch let error as NSError{
            print("Error: \(error.localizedDescription)")
        }
        
        return persons
    }
    
    func updateFirstPerson(){
        // Initialize Fetch Request
        let fetchRequest: NSFetchRequest = NSFetchRequest()
        
        // Create Entity Description
        let entityDescription: NSEntityDescription = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedObjectContext)!
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        do {
            let result: [AnyObject] = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            if (result.count > 0) {
                let person: NSManagedObject = result[0] as! NSManagedObject
                
                person.setValue(54, forKey: "age")
                
                do {
                    try person.managedObjectContext?.save()
                } catch let error as NSError{
                    print("Error: \(error.localizedDescription)")
                }
            }
            
        } catch let error as NSError{
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func deleteFirstPerson(){
        // Initialize Fetch Request
        let fetchRequest: NSFetchRequest = NSFetchRequest()
        
        // Create Entity Description
        let entityDescription: NSEntityDescription = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedObjectContext)!
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        do {
            let result: [AnyObject] = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            if (result.count > 0) {
                let person: NSManagedObject = result[0] as! NSManagedObject
                
                managedObjectContext.deleteObject(person)
                
                do {
                    try person.managedObjectContext?.save()
                } catch let error as NSError{
                    print("Error: \(error.localizedDescription)")
                }
            }
            
        } catch let error as NSError{
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func createNewAddress()->NSManagedObject{
        // Create Managed Object
        let entityDescription: NSEntityDescription = NSEntityDescription.entityForName("Address", inManagedObjectContext: managedObjectContext)!
        let newAddress: NSManagedObject = NSManagedObject(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        
        // Populate Address
        newAddress.setValue("Main Street", forKey: "street")
        newAddress.setValue("Boston", forKey: "city")
        
        //Save New Address
        do {
            try newAddress.managedObjectContext?.save()
        } catch let error as NSError{
            print("Error: \(error.localizedDescription)")
        }
        return newAddress
    }
    
    func deleteFirstAddress(){
        // Initialize Fetch Request
        let fetchRequest: NSFetchRequest = NSFetchRequest()
        
        // Create Entity Description
        let entityDescription: NSEntityDescription = NSEntityDescription.entityForName("Address", inManagedObjectContext: managedObjectContext)!
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        do {
            let result: [AnyObject] = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            if (result.count > 0) {
                let person: NSManagedObject = result[0] as! NSManagedObject
                
                managedObjectContext.deleteObject(person)
                
                do {
                    try person.managedObjectContext?.save()
                } catch let error as NSError{
                    print("Error: \(error.localizedDescription)")
                }
            }
            
        } catch let error as NSError{
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func updateRelationship(oldPerson: NSManagedObject){
        // Create Address
        let entityDescription: NSEntityDescription = NSEntityDescription.entityForName("Address", inManagedObjectContext: managedObjectContext)!
        let newAddress: NSManagedObject = NSManagedObject(entity: entityDescription, insertIntoManagedObjectContext: self.managedObjectContext)
        
        // Set Address
        newAddress.setValue("5th Avenue", forKey:"street")
        newAddress.setValue("New York", forKey:"city")
        
        // Add Address to Person
        let addresses: NSMutableSet = oldPerson.mutableSetValueForKey("addresses")
        addresses.addObject(newAddress)
    }
    
    func deleteRelationship(oldPerson: NSManagedObject){
        oldPerson.setValue(nil, forKey:"addresses")
    }
    
    func addAddressToPerson(newPerson: NSManagedObject, newAddress: NSManagedObject){
        // Add Address to Person
        newPerson.setValue(NSSet(object: newAddress), forKey: "addresses")
        
        do {
            try newPerson.managedObjectContext?.save()
        } catch let error as NSError{
            print("Error: \(error.localizedDescription)")
        }
    }
}