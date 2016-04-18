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
    
    func personWithSpouse(newPerson: NSManagedObject){
        // Create Another Person
        let entityDescription: NSEntityDescription = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedObjectContext)!
        let anotherPerson = NSManagedObject(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        
        // Set First and Last Name
        anotherPerson.setValue("Jane", forKey: "first")
        anotherPerson.setValue("Doe", forKey: "last")
        anotherPerson.setValue(42, forKey: "age")
        
        // Create Relationship
        newPerson.setValue(anotherPerson, forKey: "spouse")
    }
    
    func personFatherChild(newPerson: NSManagedObject){
        // Create a Child Person
        let entityDescription: NSEntityDescription = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedObjectContext)!
        let newChildPerson = NSManagedObject(entity: entityDescription, insertIntoManagedObjectContext: self.managedObjectContext)
        
        // Set First and Last Name
        newChildPerson.setValue("Jim", forKey: "first")
        newChildPerson.setValue("Doe", forKey: "last")
        newChildPerson.setValue(21, forKey: "age")
        
        // Create Relationship
        let children = newPerson.mutableSetValueForKey("children")
        children.addObject(newChildPerson)
         
         // Add to father
        
        // Create Another Child Person
        let anotherChildPerson = NSManagedObject(entity: entityDescription, insertIntoManagedObjectContext: self.managedObjectContext)
        
        // Set First and Last Name
        anotherChildPerson.setValue("Lucy", forKey: "first")
        anotherChildPerson.setValue("Doe", forKey: "last")
        anotherChildPerson.setValue(19, forKey: "age")
        
        // Create Relationship
        anotherChildPerson.setValue(newPerson, forKey: "father")
    }
    
    func sortFetchPerson(){
        // Create Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        // Add Sort Descriptor
        let sortDescriptor1 = NSSortDescriptor(key: "last", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "age", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        
        // Execute Fetch Request
        do {
            let result = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            
            for managedObject in result {
                if let first = managedObject.valueForKey("first"), last = managedObject.valueForKey("last") {
                    print("\(first) \(last)")
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
    
    func predicateFetchPerson(){
        // Fetching
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        // Create Predicate
        let predicate = NSPredicate(format: "%K == %@", "last", "Doe")
        fetchRequest.predicate = predicate
        
        // Add Sort Descriptor
        let sortDescriptor1 = NSSortDescriptor(key: "last", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "age", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        
        // Execute Fetch Request
        do {
            let result = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            
            for managedObject in result {
                if let first = managedObject.valueForKey("first"), last = managedObject.valueForKey("last"), age = managedObject.valueForKey("age") {
                    print("\(first) \(last) (\(age))")
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
//        let predicate = NSPredicate(format: "%K CONTAINS[c] %@ AND %K < %i", "first", "j", "age", 30)
//        let predicate = NSPredicate(format: "%K == %@", "father.first", "Bart")
    }
    
}