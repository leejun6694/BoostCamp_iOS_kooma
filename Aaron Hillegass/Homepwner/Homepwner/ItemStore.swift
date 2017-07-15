//
//  ItemStore.swift
//  Homepwner
//
//  Created by JUN LEE on 2017. 7. 15..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class ItemStore {
    
    // MARK: Properties
    
    var allItems = [Item]()
    
    // MARK: Initializer
    init() {
        for _ in 0..<5 {
            let _ = createItem()
        }
    }
    
    // MARK: Functions
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
}
