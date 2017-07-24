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
        
        updateRecord()
    }
    
    func removeRecord(record: Record) {
        if let index = allRecords.index(of: record) {
            allRecords.remove(at: index)
        }
        
        updateRecord()
    }
    
    func updateRecord() {
        allRecords.sort { $0.record < $1.record }
        
        if allRecords.count == 0 {
            maxRecord.name = "- --:--:--"
            maxRecord.record = 360000
        }
        else {
            maxRecord.name = allRecords[0].name
            maxRecord.record = allRecords[0].record
            maxRecord.dateCreated = allRecords[0].dateCreated
        }
    }
}
