//
//  ImageTableViewCell.swift
//  ImageBoard
//
//  Created by JUN LEE on 2017. 7. 31..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    let cellImageView: UIImageView = UIImageView()
    let titleLabel: UILabel = UILabel()
    let nickNameLabel: UILabel = UILabel()
    let createdLabel: UILabel = UILabel()
    
    // MARK: Draw
    
    func createCellImageView() {
        self.addSubview(cellImageView)
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        
        cellImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cellImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        cellImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cellImageView.widthAnchor.constraint(equalTo: cellImageView.heightAnchor).isActive = true
    }
    
    func createTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: cellImageView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 8.0).isActive = true
    }
    
    func createNickNameLabel() {
        self.addSubview(nickNameLabel)
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nickNameLabel.centerYAnchor.constraint(equalTo: cellImageView.centerYAnchor).isActive = true
        nickNameLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
    }
    
    func createCreatedLabel() {
        self.addSubview(createdLabel)
        createdLabel.translatesAutoresizingMaskIntoConstraints = false
        
        createdLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        createdLabel.bottomAnchor.constraint(equalTo: cellImageView.bottomAnchor).isActive = true
    }
}
