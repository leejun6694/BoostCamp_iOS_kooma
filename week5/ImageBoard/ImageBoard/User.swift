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
                let email = user?["email"] as? String,
                let nickName = user?["nickname"] as? String else {
                    return .unauthorized
            }
            print(email)
            print(nickName)
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
                let email = user?["email"] as? String,
                let nickName = user?["nickname"] as? String,
                let password = user?["password"] as? String else {
                    return .overlaped
            }
            print(email)
            print(nickName)
            print(password)
        }
        catch {
            return .overlaped
        }
        
        return .ok
    }
}
