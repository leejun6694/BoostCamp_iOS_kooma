//
//  ImageBoardAPI.swift
//  ImageBoard
//
//  Created by JUN LEE on 2017. 7. 30..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import Foundation

enum Method: String {
    case login = "login"
    case signup = "user"
}

struct ImageBoardAPI {
    
    // MARK: Type Properties
    
    private static let baseURLString = "https://ios-api.boostcamp.connect.or.kr/"
    
    static func methodURL(method: Method) -> URL {
        let url = URL(string: baseURLString + method.rawValue)!
        
        return url
    }
}
