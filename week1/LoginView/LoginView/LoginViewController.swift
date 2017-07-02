//
//  LoginViewController.swift
//  Login_view
//
//  Created by JUN LEE on 2017. 7. 2..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var idField: UITextField!
    @IBOutlet var pwField: UITextField!
    
    var inputId:String = ""
    var inputPw:String = ""
    
    // Print TextFields text
    @IBAction func logIn(sender: AnyObject) {        
        if let idFieldText = idField.text {
            inputId = idFieldText
        }
        else {
            inputId = ""
        }
        
        if let pwFieldText = pwField.text {
            inputPw = pwFieldText
        }
        else {
            inputPw = ""
        }
        
        print("touch up inside - sign in")
        print("ID : \(inputId), PW : \(inputPw)")
    }
    
    @IBAction func signUp(sender: AnyObject) {
        print("touch up inside - sign up")
    }
    
    // Dissmiss 'keyboard view' when touch up anywhere (no textfield)
    @IBAction func dissmissKeyboard(sender: AnyObject) {
        idField.resignFirstResponder()
        pwField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        pwField.isSecureTextEntry = true
    }
    
}
