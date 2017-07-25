//
//  MyTextField.swift
//  Homepwner
//
//  Created by JUN LEE on 2017. 7. 25..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class MyTextField: UITextField {
    
    override func becomeFirstResponder() -> Bool {
        self.borderStyle = .none
        super.becomeFirstResponder()
        
        return false
    }
    
    override func resignFirstResponder() -> Bool {
        self.borderStyle = .roundedRect
        super.resignFirstResponder()
        
        return false
    }
}
