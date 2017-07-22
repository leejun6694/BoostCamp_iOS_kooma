//
//  PlayViewController.swift
//  OneToTwentyFive
//
//  Created by JUN LEE on 2017. 7. 22..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    // MARK: Properties
    
    let maxLabel: UILabel! = UILabel()
    let maxRecordLabel: UILabel! = UILabel()
    let currentRecordLabel: UILabel! = UILabel()
    let playView: UIView! = UIView()
    let startButton: UIButton = UIButton()
    let homeButton: UIButton = UIButton()
    let historyButton: UIButton = UIButton()
    let RGBpoint: CGFloat = 255.0
    
    var gameButtonsStackView: UIStackView! = nil
    let gameButtons: GameButton = GameButton()
    
    // MARK: Draw
    
    func createMaxLabel() {
        maxLabel.text = "최고기록"
        maxLabel.textColor = UIColor(red: 92.0/RGBpoint, green: 120.0/RGBpoint, blue: 140.0/RGBpoint, alpha: 1.0)
        maxLabel.textAlignment = .center
        maxLabel.font = UIFont(name: maxLabel.font.fontName, size: 18.0)
        self.view.addSubview(maxLabel)
        
        maxLabel.translatesAutoresizingMaskIntoConstraints = false
        maxLabel.bottomAnchor.constraint(equalTo: maxRecordLabel.topAnchor, constant: -5.0).isActive = true
        maxLabel.leadingAnchor.constraint(equalTo: maxRecordLabel.leadingAnchor).isActive = true
    }
    
    func createMaxRecordLabel() {
        maxRecordLabel.text = "- --:--:--"
        maxRecordLabel.textColor = UIColor(red: 92.0/RGBpoint, green: 120.0/RGBpoint, blue: 140.0/RGBpoint, alpha: 1.0)
        maxRecordLabel.textAlignment = .center
        maxRecordLabel.font = UIFont(name: maxRecordLabel.font.fontName, size: 20.0)
        self.view.addSubview(maxRecordLabel)
        
        maxRecordLabel.translatesAutoresizingMaskIntoConstraints = false
        maxRecordLabel.bottomAnchor.constraint(equalTo: playView.topAnchor, constant: -8.0).isActive = true
        maxRecordLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15.0).isActive = true
    }
    
    func createCurrentRecordLabel() {
        currentRecordLabel.text = "00:00:00"
        currentRecordLabel.textColor = UIColor(red: 111.0/RGBpoint, green: 167.0/RGBpoint, blue: 145.0/RGBpoint, alpha: 1.0)
        currentRecordLabel.textAlignment = .center
        currentRecordLabel.font = UIFont(name: currentRecordLabel.font.fontName, size: 25.0)
        self.view.addSubview(currentRecordLabel)
        
        currentRecordLabel.translatesAutoresizingMaskIntoConstraints = false
        currentRecordLabel.topAnchor.constraint(equalTo: maxRecordLabel.topAnchor).isActive = true
        currentRecordLabel.bottomAnchor.constraint(equalTo: maxRecordLabel.bottomAnchor).isActive = true
        currentRecordLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15.0).isActive = true
    }
    
    func createPlayView() {
        self.view.addSubview(playView)
        
        playView.translatesAutoresizingMaskIntoConstraints = false
        playView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        playView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        playView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.54).isActive = true
        playView.widthAnchor.constraint(equalTo: playView.heightAnchor).isActive = true
        
        createStartButton()
    }
    
    func createStartButton() {
        startButton.setTitle("PRESS TO START!!", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor(red: 220.0/RGBpoint, green: 104.0/RGBpoint, blue: 80.0/RGBpoint, alpha: 1.0)
        startButton.titleLabel?.font = UIFont(name: (startButton.titleLabel?.font.fontName)!, size: 30.0)
        playView.addSubview(startButton)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.topAnchor.constraint(equalTo: playView.topAnchor).isActive = true
        startButton.leadingAnchor.constraint(equalTo: playView.leadingAnchor).isActive = true
        startButton.bottomAnchor.constraint(equalTo: playView.bottomAnchor).isActive = true
        startButton.trailingAnchor.constraint(equalTo: playView.trailingAnchor).isActive = true
        startButton.addTarget(self, action: #selector(clickStartButton(_:)), for: .touchUpInside)
    }
    
    func createHomeButton() {
        homeButton.setTitle("HOME", for: .normal)
        homeButton.setTitleColor(.white, for: .normal)
        homeButton.backgroundColor = UIColor(red: 220.0/RGBpoint, green: 125.0/RGBpoint, blue: 104.0/RGBpoint, alpha: 1.0)
        self.view.addSubview(homeButton)
        
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        homeButton.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -45.0).isActive = true
        homeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        homeButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        homeButton.addTarget(self, action: #selector(clickHomeButton(_:)), for: .touchUpInside)
    }
    
    func createHistoryButton() {
        historyButton.setTitle("HISTORY", for: .normal)
        historyButton.setTitleColor(.white, for: .normal)
        historyButton.backgroundColor = UIColor(red: 220.0/RGBpoint, green: 125.0/RGBpoint, blue: 104.0/RGBpoint, alpha: 1.0)
        self.view.addSubview(historyButton)
        
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        historyButton.topAnchor.constraint(equalTo: homeButton.topAnchor).isActive = true
        historyButton.bottomAnchor.constraint(equalTo: homeButton.bottomAnchor).isActive = true
        historyButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        historyButton.widthAnchor.constraint(equalTo: homeButton.widthAnchor).isActive = true
        historyButton.leadingAnchor.constraint(equalTo: homeButton.trailingAnchor).isActive = true
    }
    
    func updateView() {
        createPlayView()
        createHomeButton()
        createHistoryButton()
        createMaxRecordLabel()
        createMaxLabel()
        createCurrentRecordLabel()
    }
    
    // MARK: Action
    
    func clickHomeButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func clickStartButton(_ sender: AnyObject) {
        historyButton.isEnabled = false
        historyButton.titleLabel!.alpha = 0.5
        
        startButton.removeFromSuperview()
        
        gameButtonsStackView = UIStackView()
        gameButtonsStackView = gameButtons
        playView.addSubview(gameButtonsStackView)
        gameButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        gameButtonsStackView.topAnchor.constraint(equalTo: playView.topAnchor).isActive = true
        gameButtonsStackView.bottomAnchor.constraint(equalTo: playView.bottomAnchor).isActive = true
        gameButtonsStackView.leadingAnchor.constraint(equalTo: playView.leadingAnchor).isActive = true
        gameButtonsStackView.trailingAnchor.constraint(equalTo: playView.trailingAnchor).isActive = true
    }
    
    // MARK: override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
}
