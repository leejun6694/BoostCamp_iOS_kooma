//
//  User.swift
//  ImageBoard
//
//  Created by JUN LEE on 2017. 7. 31..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class User {
    
    static var authorized: Bool = false
    
    static func login(fromJSON data: Data) -> LoginResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            let user = jsonObject as? [String:Any]
            
            guard
                let _ = user?["email"] as? String,
                let _ = user?["nickname"] as? String else {
                    return .unauthorized
            }
        }
        catch {
            return .unauthorized
        }
        
        return .ok
    }
    
    static func signup(fromJSON data: Data) -> SignupResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            let user = jsonObject as? [String:Any]
            
            guard
                let _ = user?["email"] as? String,
                let _ = user?["nickname"] as? String,
                let _ = user?["password"] as? String else {
                    return .overlaped
            }
        }
        catch {
            return .overlaped
        }
        
        return .ok
    }
}
