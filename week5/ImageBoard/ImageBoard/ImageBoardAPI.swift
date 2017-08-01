//
//  ImageBoardAPI.swift
//  ImageBoard
//
//  Created by JUN LEE on 2017. 7. 30..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

enum Method: String {
    case login = "login"
    case signup = "user"
    case image = ""
}

enum ImageBoardError: Error {
    case invalidJSONData
}

enum LoginResult: Int {
    case ok = 200
    case unauthorized = 401
}

enum SignupResult: Int {
    case ok = 201
    case overlaped = 403
}

enum ImageResult {
    case ok([Image])
    case fail(Error)
}

enum FetchImageResult {
    case ok(UIImage)
    case fail(Error)
}

struct ImageBoardAPI {
    
    // MARK: Type Properties
    
    private static let baseURLString = "https://ios-api.boostcamp.connect.or.kr/"
    
    static func methodURL(method: Method) -> URL {
        let url = URL(string: baseURLString + method.rawValue)!
        
        return url
    }
    
    static func images(fromJSON data: Data) -> ImageResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard let images = jsonObject as? [[String:AnyObject]] else {
                return .fail(ImageBoardError.invalidJSONData)
            }
            
            var imageArray = [Image]()
            
            for imageJSON in images {
                if let image = image(fromJSON: imageJSON) {
                    imageArray.append(image)
                }
            }
            
            return .ok(imageArray)
        }
        catch {
            return .fail(error)
        }
    }
    
    static func image(fromJSON image: [String:AnyObject]) -> Image? {
        guard
            let id = image["_id"] as? String,
            let createdAt = image["created_at"] as? Int,
            let thumbImageString = image["thumb_image_url"] as? String,
            let imageString = image["image_url"] as? String,
            let authorNickName = image["author_nickname"] as? String,
            let author = image["author"] as? String,
            let imageDesc = image["image_desc"] as? String,
            let imageTitle = image["image_title"] as? String else {
                return nil
        }
        
        let thumbImageURL: URL! = URL(string: self.baseURLString + thumbImageString)
        let imageURL: URL! = URL(string: self.baseURLString + imageString)
        
        var thumbImage: UIImage!
        let imageRequest = URLRequest(url: thumbImageURL)
        let imageSession = URLSession.shared
        
        let task = imageSession.dataTask(with: imageRequest) {
            (data, response, error) -> Void in
            
            guard let imageData = data else{
                return
            }
            thumbImage = UIImage(data: imageData)
            
        }
        task.resume()
        
        return Image(id: id, createdAt: createdAt, thumbImageURL: thumbImageURL, imageURL: imageURL, authorNickName: authorNickName, author: author, imageDesc: imageDesc, imageTitle: imageTitle, thumbImage: thumbImage)
    }
}

