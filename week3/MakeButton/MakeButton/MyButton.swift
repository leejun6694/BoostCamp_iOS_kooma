//
//  MyButton.swift
//  MakeButton
//
//  Created by JUN LEE on 2017. 7. 18..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

extension UIControlState: Hashable {
    static let all: [UIControlState] = [.normal, .selected, .disabled, .highlighted]
    public var hashValue: Int {
        return Int(rawValue)
    }
}

class MyButton: UIView {
    
    // MARK: Properties
    
    var myLabel: UILabel?
    var buttonState: UIControlState = UIControlState()
    var isEnable: Bool = true {
        didSet {
            enableButton()
        }
    }
    private var stateTitleDictionary: Dictionary = [UIControlState:String]()
    private var stateColorDictionary: Dictionary = [UIControlState:UIColor]()
    
    // MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.myLabel = UILabel()
        self.myLabel?.text = "default"
        self.myLabel?.textAlignment = .center
        self.buttonState = .normal
        self.addSubview(myLabel!)
        
        // size
        myLabel?.translatesAutoresizingMaskIntoConstraints = false
        myLabel?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        myLabel?.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        myLabel?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        myLabel?.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    
    func setTitle(_ title: String, state: UIControlState) {
        stateTitleDictionary[state] = title
        updateTitle()
    }
    
    func setTitleColor(_ color: UIColor, state: UIControlState) {
        stateColorDictionary[state] = color
        updateColor()
    }
    
//    func addTarget(_ target: Any?, action: Selector, event controlevent: UIControlEvents) {
//        let gestureRecognizer = UITapGestureRecognizer()
//        self.addGestureRecognizer(gestureRecognizer)
//        
//        switch controlevent {
//        case UIControlEvents.touchUpInside:
//            if gestureRecognizer.state == .ended {
//                gestureRecognizer.addTarget(target!, action: action)
//                
//            }
//        default :
//            break
//        }
//    }
    
    private func enableButton() {
        if self.isEnable == true {
            self.alpha = 1
            self.isUserInteractionEnabled = true
        }
        else {
            self.alpha = 0.5
            self.isUserInteractionEnabled = false
        }
    }
    
    private func updateTitle() {
        // highlighted
        if buttonState.contains(.highlighted) {
            self.alpha = 0.5
            myLabel?.text = stateTitleDictionary[.highlighted]
            
            return
        }
        
        for (state, title) in stateTitleDictionary {
            if buttonState == state {
                myLabel?.text = title
                
                break
            }
        }
    }
    
    private func updateColor() {
        // highlighted
        if buttonState.contains(.highlighted) {
            self.alpha = 0.5
            myLabel?.textColor = stateColorDictionary[.highlighted]
            
            buttonState.remove(.highlighted)
            
            return
        }
        
        for (state, color) in stateColorDictionary {
            if buttonState == state {
                myLabel?.textColor = color
                
                break
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        buttonState = buttonState.union(.highlighted)
        
        updateTitle()
        updateColor()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1.0
        
        if buttonState == .normal {
            buttonState = .selected
        }
        else {
            buttonState = .normal
        }
        updateTitle()
        updateColor()
    }
}
