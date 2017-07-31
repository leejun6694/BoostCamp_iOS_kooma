//
//  SignupViewController.swift
//  ImageBoard
//
//  Created by JUN LEE on 2017. 7. 31..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    // MARK: Properties
    
    let authority = Authority()
    
    fileprivate lazy var emailField: UITextField = {
        let emailField = UITextField()
        
        emailField.borderStyle = .roundedRect
        emailField.placeholder = "E-mail"
        emailField.translatesAutoresizingMaskIntoConstraints = false
        
        return emailField
    }()
    
    fileprivate lazy var nickNameField: UITextField = {
        let nickNameField = UITextField()
        
        nickNameField.borderStyle = .roundedRect
        nickNameField.placeholder = "Nickname"
        nickNameField.translatesAutoresizingMaskIntoConstraints = false
        
        return nickNameField
    }()
    
    fileprivate lazy var pwField: UITextField = {
        let pwField = UITextField()
        
        pwField.borderStyle = .roundedRect
        pwField.placeholder = "Password"
        pwField.translatesAutoresizingMaskIntoConstraints = false
        
        return pwField
    }()
    
    fileprivate lazy var pwCheckField: UITextField = {
        let pwCheckField = UITextField()
        
        pwCheckField.borderStyle = .roundedRect
        pwCheckField.placeholder = "Password Check"
        pwCheckField.translatesAutoresizingMaskIntoConstraints = false
        pwCheckField.translatesAutoresizingMaskIntoConstraints = false
        
        return pwCheckField
    }()
    
    fileprivate lazy var signupButton: UIButton = {
        let signupButton = UIButton(type: .system)
        let RGBPoint:CGFloat = 255.0
        
        signupButton.setTitle("가입하기", for: .normal)
        signupButton.setTitleColor(UIColor(red: 74.0/RGBPoint, green: 135.0/RGBPoint, blue: 237.0/RGBPoint, alpha: 1.0), for: .normal)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.addTarget(self, action: #selector(clickSignupButton(_:)), for: .touchUpInside)
        
        return signupButton
    }()
    
    // MARK: Actions
    
    func checkPassword() -> Bool {
        guard let password = pwField.text else { return true }
        guard let passwordCheck = pwCheckField.text else { return true }
        
        return password != passwordCheck
    }
    
    func checkField() -> Bool {
        
        return (emailField.text?.isEmpty)! || (nickNameField.text?.isEmpty)! ||
            (pwField.text?.isEmpty)! || (pwCheckField.text?.isEmpty)!
    }
    
    @objc fileprivate func clickSignupButton(_ sender: AnyObject) {
        if checkPassword() {
            self.wrongPassword()
            return
        }
        else if checkField() {
            self.blankField()
            return
        }
        
        if let email = emailField.text, let nickName = nickNameField.text, let password = pwField.text,
            let _ = pwCheckField.text {
            authority.signup(email: email, password: password, nickName: nickName) {
                (signupResult) -> Void in
                    
                    switch signupResult {
                    case .ok:
                        self.successSignup()
                    case .overlaped:
                        self.failSignup()
                    }
            }
        }
    }
    
    private func successSignup() {
        
    }
    
    private func failSignup() {
        
    }
    
    private func wrongPassword() {
        let alert = UIAlertController(title: "암호와 암호확인이 일치하지 않습니다.", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func blankField() {
        print("black")
        let alert = UIAlertController(title: "모든 항목을 입력해주세요", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "회원가입"
        
        self.view.addSubview(emailField)
        self.view.addSubview(nickNameField)
        self.view.addSubview(pwField)
        self.view.addSubview(pwCheckField)
        self.view.addSubview(signupButton)
        
        self.view.addConstraints(emailFieldConstraints())
        self.view.addConstraints(nickNameFieldConstraints())
        self.view.addConstraints(pwFieldConstraints())
        self.view.addConstraints(pwCheckFieldConstraints())
        self.view.addConstraints(signupButtonConstraints())
    }
}

// MARK: Layout Constraints

extension SignupViewController {
    
    fileprivate func emailFieldConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: emailField, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 15.0)
        let centerXConstraint = NSLayoutConstraint(item: emailField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(item: emailField, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.9, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint]
    }
    
    fileprivate func nickNameFieldConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: nickNameField, attribute: .top, relatedBy: .equal, toItem: emailField, attribute: .bottom, multiplier: 1.0, constant: 8.0)
        let leadingConstraint = NSLayoutConstraint(item: nickNameField, attribute: .leading, relatedBy: .equal, toItem: emailField, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: nickNameField, attribute: .trailing, relatedBy: .equal, toItem: emailField, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint]
    }
    
    fileprivate func pwFieldConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: pwField, attribute: .top, relatedBy: .equal, toItem: nickNameField, attribute: .bottom, multiplier: 1.0, constant: 8.0)
        let leadingConstraint = NSLayoutConstraint(item: pwField, attribute: .leading, relatedBy: .equal, toItem: nickNameField, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: pwField, attribute: .trailing, relatedBy: .equal, toItem: nickNameField, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint]
    }
    
    fileprivate func pwCheckFieldConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: pwCheckField, attribute: .top, relatedBy: .equal, toItem: pwField, attribute: .bottom, multiplier: 1.0, constant: 8.0)
        let leadingConstraint = NSLayoutConstraint(item: pwCheckField, attribute: .leading, relatedBy: .equal, toItem: pwField, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: pwCheckField, attribute: .trailing, relatedBy: .equal, toItem: pwField, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint]
    }
    
    fileprivate func signupButtonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: signupButton, attribute: .top, relatedBy: .equal, toItem: pwCheckField, attribute: .bottom, multiplier: 1.0, constant: 15.0)
        let centerXConstraint = NSLayoutConstraint(item: signupButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, centerXConstraint]
    }
}
