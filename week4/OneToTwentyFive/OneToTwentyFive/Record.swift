//
//  Record.swift
//  OneToTwentyFive
//
//  Created by JUN LEE on 2017. 7. 23..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class Record {
    
    var name: String
    var record: Int
    var dateCreated: Date
    
    init(name: String, record: Int) {
        self.name = name
        self.record = record
        self.dateCreated = Date()
    }
}
