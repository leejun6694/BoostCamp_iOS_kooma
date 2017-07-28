//
//  ImageStore.swift
//  Homepwner
//
//  Created by JUN LEE on 2017. 7. 28..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class ImageStore: NSObject {
    
    let cache = NSCache<NSString, UIImage>()
    
    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func imageForKey(key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func deleteImageForKey(key: String) {
        cache.removeObject(forKey: key as NSString)
    }
}
