//
//  MyButton.swift
//  MakeButton
//
//  Created by JUN LEE on 2017. 7. 18..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

/* 좋아요! Dictionary의 key로 사용하려면 Hashable 프로토콜을 준수해야하죠. 왜 그럴까요? */
extension UIControlState: Hashable {
    static let all: [UIControlState] = [.normal, .selected, .disabled, .highlighted]
    public var hashValue: Int {
        return Int(rawValue)
    }
}

class MyButton: UIView {
    
    // MARK: Properties
    
    var myLabel: UILabel?
    
    /* UIControlState()로 생성된 기본값이 normal인지 모른다면 헷갈릴 수 있겠죠? 조금 더 명확히 써주는 것이 좋겠습니다 */
    var buttonState: UIControlState = .normal
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