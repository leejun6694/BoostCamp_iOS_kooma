//
//  Image.swift
//  ImageBoard
//
//  Created by JUN LEE on 2017. 8. 1..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class Image {
    
    let id: String
    let createdAt: Int
    let thumbImageURL: String
    let imageURL: String
    let authorNickName: String
    let author: String
    let imageDesc: String
    let imageTitle: String
    
    init(id: String, createdAt: Int, thumbImageURL: String, imageURL: String, authorNickName: String,
         author: String, imageDesc: String, imageTitle: String) {
        self.id = id
        self.createdAt = createdAt
        self.thumbImageURL = thumbImageURL
        self.imageURL = imageURL
        self.authorNickName = authorNickName
        self.author = author
        self.imageDesc = imageDesc
        self.imageTitle = imageTitle
    }
}
