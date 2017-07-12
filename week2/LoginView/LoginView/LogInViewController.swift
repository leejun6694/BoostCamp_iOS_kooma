//
//  LoginViewController.swift
//  Login_view
//
//  Created by JUN LEE on 2017. 7. 2..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet var idField: UITextField!
    @IBOutlet var pwField: UITextField!
    
    // Print TextFields text
    @IBAction func logIn(sender: AnyObject) {
        print("touch up inside - sign in")
        print("ID : \(idField.text ?? ""), PW : \(pwField.text ?? "")")
    }
    
    @IBAction func signUp(sender: AnyObject) {
        
    }
    
    // Dissmiss 'keyboard view' when touch up anywhere (no textfield)
    @IBAction func dismissKeyboard(sender: AnyObject) {
        self.view.endEditing(true)
//        idField.resignFirstResponder()
//        pwField.resignFirstResponder()
    }
    
}
