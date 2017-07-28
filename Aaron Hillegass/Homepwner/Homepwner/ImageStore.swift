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
    
    func imageURLForKey(key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent(key)
    }
    
    func imageForKey(key: String) -> UIImage? {
        //        return cache.object(forKey: key as NSString)
        
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
        
        // 이미지의 전체 URL을 만든다
        let url = imageURLForKey(key: key)
        
//        // 이미지를 JPEG 데이터로 만든다
//        if let data = UIImageJPEGRepresentation(image, 0.5) {
//            // 이 데이터를 전체 URL에 쓴다
//            let _ = try? data.write(to: url, options: [.atomic])
//        }
        
        if let data = UIImagePNGRepresentation(image) {
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
