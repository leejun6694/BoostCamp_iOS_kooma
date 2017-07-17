//
//  ItemCell.swift
//  Homepwner
//
//  Created by JUN LEE on 2017. 7. 17..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    // MARK: Functions
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont
        
        
        
        let captionFont = UIFont.preferredFont(forTextStyle: .caption1)
        serialNumberLabel.font = captionFont
    }
}
