//
//  RecordStore.swift
//  OneToTwentyFive
//
//  Created by JUN LEE on 2017. 7. 23..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class RecordStore {
    
    // MARK: Properties
    
    var allRecords = [Record]()
    var maxRecord: Record! = Record(name: "default", record: 360000)
    
    // MARK: Functions
    
    func createRecord(newRecord: Record) {
        allRecords.append(newRecord)
        
        updateRecord(record: newRecord)
    }
    
    func removeRecord(record: Record) {
        if let index = allRecords.index(of: record) {
            allRecords.remove(at: index)
        }
    }
    
    func updateRecord(record: Record) {
        if record.record < maxRecord.record {
            maxRecord.record = record.record
            maxRecord.name = record.name
            maxRecord.dateCreated = record.dateCreated
        }
    }
}
