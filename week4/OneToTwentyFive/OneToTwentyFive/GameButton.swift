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
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        createGameButtons()
    }
    
    // MARK: Functions
    
    private func createGameButtons() {
        self.axis = .vertical
        self.distribution = .fillEqually
        self.spacing = 8.0
        
        for _ in 0...4 {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            addArrangedSubview(stackView)
            
            for _ in 0...4 {
                let button = UIButton()
                
                button.setTitle("-", for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = UIColor(red: 71.0/RGBpoint, green: 86.0/RGBpoint, blue: 136.0/RGBpoint, alpha: 1.0)
                
                stackView.addArrangedSubview(button)
                stackView.distribution = .fillEqually
                stackView.spacing = 8.0
                gameButtons.append(button)
            }
        }
    }
}
