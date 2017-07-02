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
    
    var input_id:String = ""
    var input_pw:String = ""
    
    @IBAction func logIn(sender: AnyObject) {        
        if let text = idField.text {
            input_id = text
        }
        else {
            input_id = ""
        }
        
        if let text = pwField.text {
            input_pw = text
        }
        else {
            input_pw = ""
        }
        
        print("touch up inside - sign in")
        print("ID : \(input_id), PW : \(input_pw)")
    }
    
    @IBAction func signUp(sender: AnyObject) {
        print("touch up inside - sign up")
    }
    
    @IBAction func dissmissKeyboard(sender: AnyObject) {
        idField.resignFirstResponder()
        pwField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        pwField.isSecureTextEntry = true
    }
    
}
