//
//  LoginViewController.swift
//  ImageBoard
//
//  Created by JUN LEE on 2017. 7. 30..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Properties
    
    fileprivate lazy var idField: UITextField = {
        let idField = UITextField()
        
        idField.borderStyle = .roundedRect
        idField.placeholder = "E-mail"
        idField.translatesAutoresizingMaskIntoConstraints = false
        
        return idField
    }()
    
    fileprivate lazy var pwField: UITextField = {
        let pwField = UITextField()
        
        pwField.borderStyle = .roundedRect
        pwField.placeholder = "Password"
        pwField.isSecureTextEntry = true
        pwField.translatesAutoresizingMaskIntoConstraints = false
        
        return pwField
    }()
    
    fileprivate lazy var loginButton: UIButton = {
        let loginButton = UIButton(type: .system)
        let RGBPoint:CGFloat = 255.0
        
        loginButton.setTitle("로그인", for: .normal)
        loginButton.setTitleColor(UIColor(red: 74.0/RGBPoint, green: 135.0/RGBPoint, blue: 237.0/RGBPoint, alpha: 1.0), for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        return loginButton
    }()
    
    fileprivate lazy var signinButton: UIButton = {
        let signinButton = UIButton(type: .system)
        let RGBPoint:CGFloat = 255.0
        
        signinButton.setTitle("회원가입", for: .normal)
        signinButton.setTitleColor(UIColor(red: 204.0/RGBPoint, green: 104.0/RGBPoint, blue: 77.0/RGBPoint, alpha: 1.0), for: .normal)
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        
        return signinButton
    }()
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "로그인"
        
        self.view.addSubview(idField)
        self.view.addSubview(pwField)
        self.view.addSubview(loginButton)
        self.view.addSubview(signinButton)
        
        self.view.addConstraints(idFieldConstraints())
        self.view.addConstraints(pwFieldConstraints())
        self.view.addConstraints(loginButtonConstraints())
        self.view.addConstraints(signinButtonConstraints())
    }
}

// MARK: Layout Constraints

extension LoginViewController {
    fileprivate func idFieldConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(item: idField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: idField, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 15.0)
        let widthConstraint = NSLayoutConstraint(item: idField, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.9, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint]
    }
    
    fileprivate func pwFieldConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: pwField, attribute: .top, relatedBy: .equal, toItem: idField, attribute: .bottom, multiplier: 1.0, constant: 8.0)
        let leadingConstraint = NSLayoutConstraint(item: pwField, attribute: .leading, relatedBy: .equal, toItem: idField, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: pwField, attribute: .trailing, relatedBy: .equal, toItem: idField, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint]
    }
    
    fileprivate func loginButtonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem: pwField, attribute: .bottom, multiplier: 1.0, constant: 10.0)
        let centerXConstraint = NSLayoutConstraint(item: loginButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, centerXConstraint]
    }
    
    fileprivate func signinButtonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: signinButton, attribute: .top, relatedBy: .equal, toItem: loginButton, attribute: .bottom, multiplier: 1.0, constant: 15.0)
        let centerXConstraint = NSLayoutConstraint(item: signinButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, centerXConstraint]
    }
}
