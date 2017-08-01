//
//  ImageItem.swift
//  ImageBoard
//
//  Created by JUN LEE on 2017. 8. 1..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class ImageItem: NSObject {
    
    let cache = NSCache<NSString, UIImage>()
    
    func imageURLForKey(key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent(key)
    }
    
    // 만약 동일한 주소의 이미지가 변경되었다면 어떻게 해야할까요?
    func imageForKey(key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        
        let url = imageURLForKey(key: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as NSString)
        
        return imageFromDisk
    }
    
    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        
        let url = imageURLForKey(key: key)
        
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            let _ = try? data.write(to: url, options: [.atomic])
        }
    }
    
    func deleteImageForKey(key: String) {
        cache.removeObject(forKey: key as NSString)
        
        let url = imageURLForKey(key: key)
        
        do {
            try FileManager.default.removeItem(at: url)
        }
        catch let deleteError {
            print("Error removing the image from disk: \(deleteError)")
        }
    }
}
