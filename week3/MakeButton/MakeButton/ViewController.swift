//
//  ViewController.swift
//  MakeButton
//
//  Created by JUN LEE on 2017. 7. 18..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    let doButton: UIButton = UIButton()
    let enableButton: UIButton = UIButton()
    var highlightedNumber = 1
    
    // MARK: Functions
    
    func createButton() {
        // doButton
        doButton.setTitle("normal", for: .normal)
        doButton.setTitleColor(.yellow, for: .normal)
        doButton.setTitle("selected", for: .selected)
        doButton.setTitleColor(.green, for: .selected)
        
        doButton.backgroundColor = .black
        doButton.addTarget(self, action: #selector(touchDownDoButton(sender:)), for: .touchDown)
        doButton.addTarget(self, action: #selector(touchUpDoButton(sender:)), for: .touchUpInside)
        doButton.frame = CGRect(x: self.view.center.x - 100, y: self.view.center.y - 100, width: 200, height: 50)
        
        // enableButton
        enableButton.setTitle("Disable the button", for: .normal)
        enableButton.setTitleColor(.black, for: .normal)
        enableButton.backgroundColor = .white
        enableButton.addTarget(self, action: #selector(clickEnableButton(sender:)), for: .touchUpInside)
        enableButton.frame = CGRect(x: self.view.center.x - 100, y: self.view.center.y - 30, width: 200, height: 50)
    
        self.view.addSubview(doButton)
        self.view.addSubview(enableButton)
    }
    
    func touchDownDoButton(sender: AnyObject) {
        doButton.alpha = 0.5
        doButton.isHighlighted = true
        doButton.isSelected = false
        
        doButton.setTitle("highlighted\(highlightedNumber)", for: .highlighted)
        if highlightedNumber == 1 {
            doButton.setTitleColor(.white, for: .highlighted)
        }
        else {
            doButton.setTitleColor(.red, for: .highlighted)
        }
    }
    
    func touchUpDoButton(sender: AnyObject) {
        doButton.alpha = 1.0
        doButton.isHighlighted = false
        
        if highlightedNumber == 1 {
            doButton.isSelected = true
            highlightedNumber += 1
        }
        else {
            doButton.isSelected = false
            highlightedNumber -= 1
        }
        
        print("touch up inside")
        print("button tapped")
    }
    
    func clickEnableButton(sender: AnyObject) {
        // doButton title setting
        if doButton.isSelected == true {
            doButton.setTitle("selected", for: .normal)
            doButton.setTitleColor(.green, for: .normal)
        }
        else {
            doButton.setTitle("normal", for: .normal)
            doButton.setTitleColor(.yellow, for: .normal)
        }
        
        // enableButton title setting
        if doButton.isEnabled == true {
            doButton.isEnabled = false
            doButton.alpha = 0.5
            enableButton.setTitle("Enable the button", for: .normal)
        }
        else {
            doButton.isEnabled = true
            doButton.alpha = 1.0
            enableButton.setTitle("Disable the button", for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

