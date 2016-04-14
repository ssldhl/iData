//
//  ViewController.swift
//  iData
//
//  Created by Sushil Dahal on 4/14/16.
//  Copyright © 2016 Sushil Dahal. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let db: Database = Database()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        simpleDatabase()
        realtionalDatabase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    MARK: Database
    func simpleDatabase(){
//        Database Location: /Users/<USER>/Library/Developer/CoreSimulator/Devices/<DEVICE_ID>/data/Containers/Data/Application/<APPLICATION_ID>/Documents/SingleViewCoreData.sqlite.
        
//        Create New Person
        db.createNewPerson()
        
//        Update First Person
        db.updateFirstPerson()
        
//        Delete First Person
        db.deleteFirstPerson()
        
//        Fetch Person
        db.getAllPersons()
    }
    
    func realtionalDatabase(){
//        Add Address to Person
        let newPerson: NSManagedObject = db.createNewPerson()
        let newAddress: NSManagedObject = db.createNewAddress()
        db.addAddressToPerson(newPerson, newAddress: newAddress)
        
        // Update Relationship
        let updatePersons: [NSManagedObject] = db.getAllPersons()
        if(updatePersons.count > 0){
            let oldPerson: NSManagedObject = updatePersons[0]
            db.updateRelationship(oldPerson)
        }else{
            print("Persons Count: \(updatePersons.count)")
        }
        
        // Delete Relationship
        let persons: [NSManagedObject] = db.getAllPersons()
        if(persons.count > 0){
            let oldPerson: NSManagedObject = persons[0]
            db.updateRelationship(oldPerson)
        }else{
            print("Persons Count: \(persons.count)")
        }
    }
}

