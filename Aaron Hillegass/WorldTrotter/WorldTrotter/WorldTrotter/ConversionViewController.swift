//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by JUN LEE on 2017. 7. 1..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        // super의 viewDidLoad 구현을 항상 호출한다
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
    }
    
    // 은메달 과제 : 다크 모드
    override func viewWillAppear(_ animated: Bool) {
        let calendar = NSCalendar.current
        let date = NSDate()
        let currentHour = calendar.component(.hour, from: date as Date)
        
        switch currentHour {
        case 6...12 :
            self.view.backgroundColor = UIColor(red: 255/255, green: 254/255, blue: 136/255, alpha: 1.0)
        case 13...20 :
            self.view.backgroundColor = UIColor(red: 155/255, green: 254/255, blue: 255/255, alpha: 1.0)
        default :
            self.view.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 123/255, alpha: 1.0)
        }
        
    }
    
    // property value가 바뀔 때마다 호출되야 하므로 property observer를 사용함
    // value가 바껴도 celsiusLabel의 text가 바뀌지 않는다
    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        }
        else {
            return nil
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        
        return nf
    }()
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: value))
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = value
        }
        else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
//        print("Current text: \(String(describing: textField.text))")
//        print("Replacement text: \(string)")
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
        }
        else {
            return true
        }
    }
}
