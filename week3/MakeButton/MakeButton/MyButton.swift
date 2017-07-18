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

class MyButton: UIView, UIGestureRecognizerDelegate {
    
    // MARK: Properties
    
    var myLabel: UILabel?
    var imageView: UIImageView?
    var buttonState: UIControlState = UIControlState()
    var isEnable: Bool = true {
        didSet {
            enableButton()
        }
    }
    private var stateTitleDictionary: Dictionary = [UIControlState:String]()
    private var stateColorDictionary: Dictionary = [UIControlState:UIColor]()
    private var stateImageDictionary: Dictionary = [UIControlState:UIImageView]()
    
    // MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.myLabel = UILabel()
        self.myLabel?.text = "default"
        self.myLabel?.textAlignment = .center
        imageView = UIImageView()
        self.buttonState = .normal
        self.addSubview(myLabel!)
        self.addSubview(imageView!)
        
        // imgview size
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView?.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView?.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        // label size
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
    
    func setBackgroundImage(image: UIImageView, state: UIControlState) {
        stateImageDictionary[state] = image
        updateImage()
    }
    
    func backgroundImage(state: UIControlState) -> UIImageView {
        return stateImageDictionary[state]!
    }
    
    func addTarget(_ target: Any?, action: Selector, event controlevent: UIControlEvents) {
        let tapGestureRecognizer = UITapGestureRecognizer()
        
        switch controlevent {
        case UIControlEvents.touchUpInside :
            tapGestureRecognizer.addTarget(target!, action: action)
            tapGestureRecognizer.cancelsTouchesInView = false
            
            addGestureRecognizer(tapGestureRecognizer)
        default :
            break
        }
    }
    
    // MARK: private, override
    
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
        for (state, title) in stateTitleDictionary {
            if buttonState == state {
                myLabel?.text = title
                
                break
            }
        }
    }
    
    private func updateColor() {
        for (state, color) in stateColorDictionary {
            if buttonState == state {
                myLabel?.textColor = color
                
                break
            }
        }
    }
    
    private func updateImage() {
        for (state, image) in stateImageDictionary {
            if buttonState == state {
                self.imageView = image
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 0.5
        
        if buttonState == .selected {
            buttonState = buttonState.union(.highlighted)
        }
        else {
            buttonState = .highlighted
        }
        
        updateTitle()
        updateColor()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1.0
        
        if buttonState == UIControlState.selected.union(.highlighted) {
            buttonState = .normal
        }
        else {
            buttonState = .selected
        }
        
        updateTitle()
        updateColor()
    }
}
