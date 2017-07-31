//
//  Authority.swift
//  ImageBoard
//
//  Created by JUN LEE on 2017. 7. 31..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

enum LoginResult: Int {
    case ok = 200
    case unauthorized = 401
}

enum SignupResult: Int {
    case ok = 201
    case overlaped = 403
}

class Authority {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        
        return URLSession(configuration: config)
    }()
    
    // MARK: Login
    
    private func processLogin(data: Data?, error: Error?) -> LoginResult {
        guard let jsonData = data else {
            return .unauthorized
        }
        return User.login(fromJSON: jsonData)
    }
    
    func login(email: String, password: String, completion: @escaping (LoginResult) -> Void) {
        let parameterDictionary = ["email" : email, "password" : password]
        
        let url = ImageBoardAPI.methodURL(method: .login)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.session = self.session
        
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            let result = self.processLogin(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    // MARK: Signup
    
    private func processSignup(data: Data?, error: Error?) -> SignupResult {
        guard let jsonData = data else {
            return .overlaped
        }
        
        return User.signup(fromJSON: jsonData)
    }
    
    func signup(email: String, password: String, nickName: String, completion: @escaping (SignupResult) -> Void) {
        let parameterDictionary = ["email" : email, "password" : password, "nickname" : nickName]
        
        let url = ImageBoardAPI.methodURL(method: .signup)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            let result = self.processSignup(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
}
