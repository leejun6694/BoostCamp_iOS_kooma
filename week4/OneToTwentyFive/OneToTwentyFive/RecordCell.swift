//
//  RecordCell.swift
//  OneToTwentyFive
//
//  Created by JUN LEE on 2017. 7. 23..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell {
    
    // MARK: Properties
    var nameLabel: UILabel! = UILabel()
    var recordLabel: UILabel! = UILabel()
    var dateCreatedLabel: UILabel! = UILabel()
    let RGBpoint: CGFloat = 255.0
    
    // MARK: Draw
    
    func createRecordLabel() {
        recordLabel.textColor = UIColor(red: 93.0/RGBpoint, green: 119.0/RGBpoint, blue: 134.0/RGBpoint, alpha: 1.0)
        self.addSubview(recordLabel)
        
        recordLabel.translatesAutoresizingMaskIntoConstraints = false
        let margins = self.layoutMarginsGuide
        recordLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        recordLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10).isActive = true
        recordLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
    }
    
    func createNameLabel() {
        nameLabel.textColor = UIColor(red: 93.0/RGBpoint, green: 119.0/RGBpoint, blue: 134.0/RGBpoint, alpha: 1.0)
        self.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let margins = self.layoutMarginsGuide
        nameLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
    }
    
    func createDateCreatedLabel() {
        dateCreatedLabel.textColor = UIColor(red: 93.0/RGBpoint, green: 119.0/RGBpoint, blue: 134.0/RGBpoint, alpha: 1.0)
        self.addSubview(dateCreatedLabel)
        
        dateCreatedLabel.translatesAutoresizingMaskIntoConstraints = false
        dateCreatedLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8).isActive = true
        dateCreatedLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        dateCreatedLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
    }
    
    // MARK: Functions
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFont(forTextStyle: .body)
        recordLabel.font = bodyFont
    
        let captionFont = UIFont.preferredFont(forTextStyle: .caption1)
        dateCreatedLabel.font = captionFont
        nameLabel.font = captionFont
    }

}
