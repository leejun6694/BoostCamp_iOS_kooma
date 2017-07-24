//
//  Record.swift
//  OneToTwentyFive
//
//  Created by JUN LEE on 2017. 7. 23..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class Record: NSObject, NSCoding {
    
    var name: String
    var record: Int
    var dateCreated: Date
    
    init(name: String, record: Int) {
        self.name = name
        self.record = record
        self.dateCreated = Date()
        
        super.init()
    }
    
    // MARK: Archiving
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(dateCreated, forKey: "dateCreated")
        aCoder.encode(record, forKey: "record")
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! Date
        record = aDecoder.decodeInteger(forKey: "record")
        
        super.init()
    }
}
