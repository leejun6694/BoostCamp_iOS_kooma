//
//  GameButton.swift
//  OneToTwentyFive
//
//  Created by JUN LEE on 2017. 7. 22..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class GameButton: UIStackView {
    
    // MARK: Properties
    
    var horizontalStacks = [UIStackView]()
    var gameButtons = [UIButton]()
    let RGBpoint: CGFloat = 255.0
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createGameButtons()
        print("hi")
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        createGameButtons()
    }
    
    // MARK: Functions
    
    private func createGameButtons() {
        self.axis = .vertical
        
        for _ in 0...4 {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            addArrangedSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
            
            for _ in 0...4 {
                let button = UIButton()
                
                button.setTitle("-", for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = UIColor(red: 71.0/RGBpoint, green: 86.0/RGBpoint, blue: 136.0/RGBpoint, alpha: 1.0)
                stackView.addArrangedSubview(button)
                gameButtons.append(button)
                
                button.translatesAutoresizingMaskIntoConstraints = false
                button.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2).isActive = true
                button.heightAnchor.constraint(equalTo: stackView.heightAnchor).isActive = true
            }
        }
    }
}
