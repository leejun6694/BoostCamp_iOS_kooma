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
    
    // MARK: Functions
    
    func createRecord(name: String, record: Int) {
        let newRecord = Record(name: name, record: record)
        allRecords.append(newRecord)
        
//        let userDefault = UserDefaults.standard
//        userDefault.set(newRecord, forKey: "\(allRecords.count)")
    }
    
    func removeRecord(record: Record) {
        if let index = allRecords.index(of: record) {
            allRecords.remove(at: index)
        }
    }
}
