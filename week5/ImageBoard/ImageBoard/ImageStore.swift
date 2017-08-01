//
//  ImageStore.swift
//  ImageBoard
//
//  Created by JUN LEE on 2017. 8. 1..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class ImageStore: NSObject {
    
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
}
