//
//  ChangeDateViewController.swift
//  Homepwner
//
//  Created by JUN LEE on 2017. 7. 25..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class ChangeDateViewController: UIViewController, UIPickerViewDelegate {
    
    // MARK: Properties
    
    var item: Item!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        item.dateCreated = datePicker.date
    }
}
