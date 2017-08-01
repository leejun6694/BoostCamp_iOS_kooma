//
//  ImageStore.swift
//  ImageBoard
//
//  Created by JUN LEE on 2017. 8. 1..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class ImageStore: NSObject {
    
    var imageItem = ImageItem()
    
    private func processImage(data: Data?, error: Error?) -> ImageResult {
        guard let jsonData = data else {
            return .fail(error!)
        }
        
        return ImageBoardAPI.images(fromJSON: jsonData)
    }
    
    func imageLoad(completion: @escaping (ImageResult) -> Void) {
        let url = ImageBoardAPI.methodURL(method: .image)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let session = appDelegate.session
        
        let task = session!.dataTask(with: request) {
            (data, response, error) -> Void in
            
            let result = self.processImage(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    private func processImageRequest(data: Data?, error: Error?) -> FetchImageResult {
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
                
                return .fail(error!)
        }
        
        return .ok(image)
    }
    
    func fetchImage(for photo: Image, completion: @escaping (FetchImageResult) -> Void) {
        let photoKey = photo.id
        if let image = imageItem.imageForKey(key: photoKey) {
            OperationQueue.main.addOperation {
                completion(.ok(image))
            }
            return
        }
        
        let request = URLRequest(url: photo.imageURL)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let session = appDelegate.session
        
        let task = session!.dataTask(with: request) {
            (data, response, error) -> Void in
            
            let result = self.processImageRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
            
            if case let .ok(image) = result {
                self.imageItem.setImage(image: image, forKey: photoKey)
            }
            
            print("Fetch Image: \(response.debugDescription)")
        }
        task.resume()
    }
}
