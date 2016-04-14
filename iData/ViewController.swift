//
//  ViewController.swift
//  iData
//
//  Created by Sushil Dahal on 4/14/16.
//  Copyright © 2016 Sushil Dahal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let db: Database = Database()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        database()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    MARK: Database
    func database(){
//        Database Location: /Users/<USER>/Library/Developer/CoreSimulator/Devices/<DEVICE_ID>/data/Containers/Data/Application/<APPLICATION_ID>/Documents/SingleViewCoreData.sqlite.
        
//        Create New Person
//        db.createNewPerson()
        
//        Update First Person
//        db.updateFirstPerson()
        
//        Delete First Person
//        db.deleteFirstPerson()
        
//        Fetch Person
        db.getAllPersons()
    }
}

