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
    
    var doButton: MyButton!
    var enableButton: MyButton!
    var btn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        // create button
        doButton = MyButton(frame: CGRect(x: self.view.center.x - 100.0, y: self.view.center.y - 100.0, width: 200.0, height: 50.0))
        doButton.setTitle("normal", state: .normal)
        doButton.setTitleColor(.yellow, state: .normal)
        doButton.setTitle("highlighted1", state: .highlighted)
        doButton.setTitleColor(.white, state: .highlighted)
        doButton.setTitle("highlighted2", state: [.selected, .highlighted])
        doButton.setTitleColor(.red, state: [.selected, .highlighted])
        doButton.setTitle("selected", state: .selected)
        doButton.setTitleColor(.green, state: .selected)
        doButton.backgroundColor = .black
        doButton.addTarget(self, action: #selector(clickDoButton(_:)), event: .touchUpInside)        
        
        enableButton = MyButton(frame: CGRect(x: self.view.center.x - 100.0, y: self.view.center.y - 30.0, width: 200.0, height: 50.0))
        enableButton.setTitle("Disable the button", state: .normal)
        enableButton.setTitleColor(.black, state: .normal)
        enableButton.setTitle("Enable the button", state: .selected)
        enableButton.setTitleColor(.black, state: .selected)
        enableButton.addTarget(self, action: #selector(clickEnableButton(_:)), event: .touchUpInside)
        
        self.view.addSubview(doButton)
        self.view.addSubview(enableButton)
    }
    
    func clickDoButton(_ sender: AnyObject) {
        print("touch up inside")
    }

    func clickEnableButton(_ sender: AnyObject) {
        if doButton.isEnable == true {
            doButton.alpha = 0.5
            doButton.isEnable = false
        }
        else {
            doButton.alpha = 1.0
            doButton.isEnable = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

