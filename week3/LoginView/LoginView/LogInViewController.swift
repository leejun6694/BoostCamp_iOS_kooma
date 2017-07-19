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
    var signInButton: MyButton!
    var signUpButton: MyButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton = MyButton()
        signUpButton = MyButton()
        self.view.addSubview(signInButton)
        self.view.addSubview(signUpButton)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.topAnchor.constraint(equalTo: pwField.bottomAnchor, constant: 8).isActive = true
        signInButton.leadingAnchor.constraint(equalTo: pwField.leadingAnchor).isActive = true
        signUpButton.topAnchor.constraint(equalTo: signInButton.topAnchor).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: pwField.trailingAnchor).isActive = true
        signInButton.widthAnchor.constraint(equalTo: signUpButton.widthAnchor).isActive = true
        signUpButton.leadingAnchor.constraint(equalTo: signInButton.trailingAnchor, constant: 8).isActive = true
        
        signInButton.setTitle("Sign In", state: .normal)
        signInButton.setTitleColor(.blue, state: .normal)
        signUpButton.setTitle("Sign Up", state: .normal)
        signUpButton.setTitleColor(.red, state: .normal)
        
        signUpButton.addTarget(self, action: #selector(clickSignUpButton(_:)), event: .touchUpInside)
    }
    
    func clickSignUpButton(_ sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    
    // Dissmiss 'keyboard view' when touch up anywhere (no textfield)
    @IBAction func dismissKeyboard(sender: AnyObject) {
        self.view.endEditing(true)
//        idField.resignFirstResponder()
//        pwField.resignFirstResponder()
    }
    
}
