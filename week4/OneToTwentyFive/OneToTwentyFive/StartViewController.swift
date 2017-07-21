//
//  StartViewController.swift
//  OneToTwentyFive
//
//  Created by JUN LEE on 2017. 7. 22..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    // MARK: Properties
    
    var homeLabel: UILabel! = UILabel()
    var playButton: UIButton! = UIButton()
    var historyButton: UIButton! = UIButton()
    let RGBpoint:CGFloat = 255.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homeLabel.text = "1 to 25"
        homeLabel.textColor = UIColor(red: 111.0/RGBpoint, green: 167.0/RGBpoint, blue: 145.0/RGBpoint, alpha: 1.0)
        homeLabel.textAlignment = .center
        homeLabel.font = UIFont(name: homeLabel.font.fontName, size: 60.0)
        self.view.addSubview(homeLabel)
        homeLabel.translatesAutoresizingMaskIntoConstraints = false
        homeLabel.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        homeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10.0).isActive = true
        homeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10.0).isActive = true
        homeLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
        
        playButton.setTitle("PLAY", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        playButton.backgroundColor = UIColor(red: 203.0/RGBpoint, green: 104.0/RGBpoint, blue: 80.0/RGBpoint, alpha: 1.0)
        self.view.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.topAnchor.constraint(equalTo: homeLabel.bottomAnchor, constant: 8.0).isActive = true
        playButton.leadingAnchor.constraint(equalTo: homeLabel.leadingAnchor).isActive = true
        playButton.heightAnchor.constraint(equalTo: homeLabel.heightAnchor).isActive = true

        historyButton.setTitle("HISTORY", for: .normal)
        historyButton.setTitleColor(.white, for: .normal)
        historyButton.backgroundColor = UIColor(red: 203.0/RGBpoint, green: 104.0/RGBpoint, blue: 80.0/RGBpoint, alpha: 1.0)
        self.view.addSubview(historyButton)
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        historyButton.topAnchor.constraint(equalTo: playButton.topAnchor).isActive = true
        historyButton.trailingAnchor.constraint(equalTo: homeLabel.trailingAnchor).isActive = true
        historyButton.heightAnchor.constraint(equalTo: playButton.heightAnchor).isActive = true
        historyButton.widthAnchor.constraint(equalTo: playButton.widthAnchor).isActive = true
        historyButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 8.0).isActive = true
    }
}
