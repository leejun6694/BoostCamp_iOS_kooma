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
    
    let authority = Authority()
    var signupFlag: Bool = false
    
    fileprivate lazy var emailField: UITextField = {
        let emailField = UITextField()
        
        emailField.borderStyle = .roundedRect
        emailField.placeholder = "E-mail"
        emailField.translatesAutoresizingMaskIntoConstraints = false
        
        emailField.text = "test@test.com" // tmp
        
        return emailField
    }()
    
    fileprivate lazy var pwField: UITextField = {
        let pwField = UITextField()
        
        pwField.borderStyle = .roundedRect
        pwField.placeholder = "Password"
        pwField.isSecureTextEntry = true
        pwField.translatesAutoresizingMaskIntoConstraints = false
        
        pwField.text = "test" // tmp
        
        return pwField
    }()
    
    fileprivate lazy var loginButton: UIButton = {
        let loginButton = UIButton(type: .system)
        let RGBPoint:CGFloat = 255.0
        
        loginButton.setTitle("로그인", for: .normal)
        loginButton.setTitleColor(UIColor(red: 74.0/RGBPoint, green: 135.0/RGBPoint, blue: 237.0/RGBPoint, alpha: 1.0), for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(clickLoginButton(_:)), for: .touchUpInside)
        
        return loginButton
    }()
    
    fileprivate lazy var signupButton: UIButton = {
        let signupButton = UIButton(type: .system)
        let RGBPoint:CGFloat = 255.0
        
        signupButton.setTitle("회원가입", for: .normal)
        signupButton.setTitleColor(UIColor(red: 204.0/RGBPoint, green: 104.0/RGBPoint, blue: 77.0/RGBPoint, alpha: 1.0), for: .normal)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.addTarget(self, action: #selector(clickSignupButton(_:)), for: .touchUpInside)
        
        return signupButton
    }()
    
    // MARK: Actions
    
    @objc fileprivate func clickLoginButton(_ sender: AnyObject) {
        if let email = emailField.text, let password = pwField.text {
            authority.login(email: email, password: password) {
                (loginResult) -> Void in
                
                switch loginResult {
                case .ok:
                    self.successLogin()
                case .unauthorized:
                    self.failLogin()
                }
            }
        }
    }
    
    private func failLogin() {
        let alert = UIAlertController(title: "알림", message: "Code : 401", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func successLogin() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func clickSignupButton(_ sender: AnyObject) {
        performSegue(withIdentifier: "segueLoginToSignup", sender: self)
    }
    
    // MARK: Override
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if signupFlag == true {
            let alert = UIAlertController(title: "회원가입완료", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "로그인"
        
        self.view.addSubview(emailField)
        self.view.addSubview(pwField)
        self.view.addSubview(loginButton)
        self.view.addSubview(signupButton)
        
        self.view.addConstraints(emailFieldConstraints())
        self.view.addConstraints(pwFieldConstraints())
        self.view.addConstraints(loginButtonConstraints())
        self.view.addConstraints(signupButtonConstraints())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueLoginToSignup" {
            self.signupFlag = false
            let destinationController = segue.destination as! SignupViewController
            destinationController.signupFlag = self.signupFlag
        }
    }
}

// MARK: Layout Constraints

extension LoginViewController {
    fileprivate func emailFieldConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(item: emailField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: emailField, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 15.0)
        let widthConstraint = NSLayoutConstraint(item: emailField, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.9, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint]
    }
    
    fileprivate func pwFieldConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: pwField, attribute: .top, relatedBy: .equal, toItem: emailField, attribute: .bottom, multiplier: 1.0, constant: 8.0)
        let leadingConstraint = NSLayoutConstraint(item: pwField, attribute: .leading, relatedBy: .equal, toItem: emailField, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: pwField, attribute: .trailing, relatedBy: .equal, toItem: emailField, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint]
    }
    
    fileprivate func loginButtonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem: pwField, attribute: .bottom, multiplier: 1.0, constant: 10.0)
        let centerXConstraint = NSLayoutConstraint(item: loginButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, centerXConstraint]
    }
    
    fileprivate func signupButtonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: signupButton, attribute: .top, relatedBy: .equal, toItem: loginButton, attribute: .bottom, multiplier: 1.0, constant: 15.0)
        let centerXConstraint = NSLayoutConstraint(item: signupButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, centerXConstraint]
    }
}
