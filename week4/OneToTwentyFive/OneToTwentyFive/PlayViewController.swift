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

    var recordTime = 1
    var currentTimer: Timer!
    var currentNumber: Int = 1
    var newRecord: Record!
    var recordStore: RecordStore!
    let gameButton: GameButton = GameButton()
    
    private lazy var gameButtonsStackView: UIStackView = {
        var gameButtonsStackView = UIStackView()
        gameButtonsStackView = self.gameButton
        
        gameButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return gameButtonsStackView
    }()
    
    private lazy var playView: UIView = {
        let playView = UIView()
        playView.translatesAutoresizingMaskIntoConstraints = false
        
        return playView
    }()
    
    private lazy var maxLabel: UILabel = {
        let maxLabel = UILabel()
        let RGBpoint: CGFloat = 255.0
        maxLabel.text = "최고기록"
        maxLabel.textColor = UIColor(red: 92.0/RGBpoint, green: 120.0/RGBpoint, blue: 140.0/RGBpoint, alpha: 1.0)
        maxLabel.textAlignment = .center
        maxLabel.font = UIFont(name: maxLabel.font.fontName, size: 18.0)
        maxLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return maxLabel
    }()
    
    private lazy var maxRecordLabel: UILabel = {
        let maxRecordLabel = UILabel()
        let RGBpoint: CGFloat = 255.0
        maxRecordLabel.text = "- --:--:--"
        maxRecordLabel.textColor = UIColor(red: 92.0/RGBpoint, green: 120.0/RGBpoint, blue: 140.0/RGBpoint, alpha: 1.0)
        maxRecordLabel.textAlignment = .center
        maxRecordLabel.font = UIFont(name: maxRecordLabel.font.fontName, size: 20.0)
        maxRecordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return maxRecordLabel
    }()
    
    private lazy var currentRecordLabel: UILabel = {
        let currentRecordLabel = UILabel()
        let RGBpoint: CGFloat = 255.0
        currentRecordLabel.text = "00:00:00"
        currentRecordLabel.textColor = UIColor(red: 111.0/RGBpoint, green: 167.0/RGBpoint, blue: 145.0/RGBpoint, alpha: 1.0)
        currentRecordLabel.textAlignment = .center
        currentRecordLabel.font = UIFont(name: currentRecordLabel.font.fontName, size: 25.0)
        currentRecordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return currentRecordLabel
    }()
    
    private lazy var startButton: UIButton = {
        let startButton = UIButton(type: .system)
        let RGBpoint: CGFloat = 255.0
        startButton.setTitle("PRESS TO START!!", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor(red: 220.0/RGBpoint, green: 104.0/RGBpoint, blue: 80.0/RGBpoint, alpha: 1.0)
        startButton.titleLabel?.font = UIFont(name: (startButton.titleLabel?.font.fontName)!, size: 30.0)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        startButton.addTarget(self, action: #selector(clickStartButton(_:)), for: .touchUpInside)
        
        return startButton
    }()
    
    private lazy var homeButton: UIButton = {
        let homeButton = UIButton(type: .system)
        let RGBpoint: CGFloat = 255.0
        homeButton.setTitle("HOME", for: .normal)
        homeButton.setTitleColor(.white, for: .normal)
        homeButton.backgroundColor = UIColor(red: 220.0/RGBpoint, green: 125.0/RGBpoint, blue: 104.0/RGBpoint, alpha: 1.0)
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        
        homeButton.addTarget(self, action: #selector(clickHomeButton(_:)), for: .touchUpInside)
        
        return homeButton
    }()
    
    private lazy var historyButton: UIButton = {
        let historyButton = UIButton(type: .system)
        let RGBpoint: CGFloat = 255.0
        historyButton.setTitle("HISTORY", for: .normal)
        historyButton.setTitleColor(.white, for: .normal)
        historyButton.backgroundColor = UIColor(red: 220.0/RGBpoint, green: 125.0/RGBpoint, blue: 104.0/RGBpoint, alpha: 1.0)
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        
        historyButton.addTarget(self, action: #selector(clickHistoryButton(_:)), for: .touchUpInside)
        
        return historyButton
    }()
    
    // MARK: Action
    
    func startTimer() {
        currentTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        recordTime += 1
        
        let minute = recordTime / 6000
        let second = (recordTime % 6000) / 100
        let miliSecond = (recordTime % 6000) % 100
        currentRecordLabel.text = String(format: "%02i:%02i:%02i", minute, second, miliSecond)
    }
    
    func clickStartButton(_ sender: AnyObject) {
        historyButton.isEnabled = false
        historyButton.titleLabel!.alpha = 0.5
        
        startButton.removeFromSuperview()
        playView.addSubview(gameButtonsStackView)
        playView.addConstraints(gameButtonsStackViewConstraint())
        
        animateGameButtons()
        
        startTimer()
    }
    
    func clickGameButton(_ sender: UIButton) {
        if Int((sender.titleLabel?.text)!)! == currentNumber {
            currentNumber = currentNumber + 1
            sender.alpha = 0.0
        }
        else {
            recordTime = recordTime + 150
        }
        
        if currentNumber == 26 {
            clickLastButton()
        }
    }
    
    func clickLastButton() {
        currentTimer.invalidate()
        historyButton.isEnabled = true
        historyButton.titleLabel!.alpha = 1.0
        
        gameButton.removeFromSuperview()
        playView.addSubview(startButton)
        playView.addConstraints(startButtonConstraint())
        
        let alertTitle = "Clear!"
        let alertMessage = "Enter your name"
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addTextField(configurationHandler: configurationTextField(textField:))
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            if let recordName = alert.textFields?[0] {
                self.newRecord = Record(name: recordName.text ?? "default", record: self.recordTime)
                self.recordStore.createRecord(newRecord: self.newRecord)
                self.updateMaxRecordLabel()
                
                self.initialGame()
            }
        })
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func configurationTextField(textField: UITextField) {
        textField.placeholder = "Enter your name"
    }
    
    func initialGame() {
        currentNumber = 1
        for index in 0...24 {
            gameButton.gameButtons[index].alpha = 1.0
        }
        
        recordTime = 0
        currentRecordLabel.text = "00:00:00"
    }
    
    private func updateMaxRecordLabel() {        
        if recordStore.allRecords.count == 0 {
            maxRecordLabel.text = "- --:--:--"
        }
        else {
            recordStore.updateRecord()
            
            let minute = recordStore.maxRecord.record / 6000
            let second = (recordStore.maxRecord.record % 6000) / 100
            let miliSecond = (recordStore.maxRecord.record % 6000) % 100
            maxRecordLabel.text = "\(recordStore.maxRecord.name) " + String(format: "%02i:%02i:%02i", minute, second, miliSecond)
        }
    }
    
    func clickHomeButton(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func clickHistoryButton(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "segueFromPlayToHistory", sender: self)
    }
    
    // MARK: Animation
    
    func animateGameButtons() {
        UIView.animate(withDuration: 0.15, animations: {
            for index in 0...24 {
                self.gameButton.gameButtons[index].titleLabel!.alpha = 0.0
            }
        }, completion: { _ in
            self.animateGameButtonsAppear()
        })
    }
    
    func animateGameButtonsAppear() {
        UIView.animate(withDuration: 0.15, animations: {
            for index in 0...24 {
                self.gameButton.gameButtons[index].titleLabel!.alpha = 1.0
                
                var gameNumbers = [Int](1...25)
                
                for subIndex in 0...24 {
                    let random = Int(arc4random_uniform(UInt32(gameNumbers.count)))
                    
                    self.gameButton.gameButtons[subIndex].setTitle("\(gameNumbers[random])", for: .normal)
                    self.gameButton.gameButtons[subIndex].addTarget(self, action: #selector(self.clickGameButton(_:)), for: .touchDown)
                    gameNumbers.remove(at: random)
                    
                }
            }
        })
    }
    
    // MARK: Override
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateMaxRecordLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(playView)
        playView.addSubview(startButton)
        view.addSubview(maxRecordLabel)
        view.addSubview(maxLabel)
        view.addSubview(currentRecordLabel)
        view.addSubview(homeButton)
        view.addSubview(historyButton)
        
        view.addConstraints(playViewConstraint())
        playView.addConstraints(startButtonConstraint())
        view.addConstraints(maxRecordLabelConstraint())
        view.addConstraints(maxLabelConstraint())
        view.addConstraints(currentRecordLabelConstraint())
        view.addConstraints(homeButtonConstraint())
        view.addConstraints(historyButtonConstraint())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFromPlayToHistory" {
            let destination = segue.destination as! HistoryViewController
            destination.recordStore = self.recordStore
        }
    }

    // Constraint
    
    private func playViewConstraint() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(item: playView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(item: playView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(item: playView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.54, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(item: playView, attribute: .width, relatedBy: .equal, toItem: playView, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, heightConstraint, widthConstraint]
    }
    
    private func maxRecordLabelConstraint() -> [NSLayoutConstraint] {
        let bottomConstraint = NSLayoutConstraint(item: maxRecordLabel, attribute: .bottom, relatedBy: .equal, toItem: playView, attribute: .top, multiplier: 1.0, constant: -8.0)
        let leadingConstraint = NSLayoutConstraint(item: maxRecordLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 15.0)
        
        return [bottomConstraint, leadingConstraint]
    }
    
    private func maxLabelConstraint() -> [NSLayoutConstraint] {
        let bottomConstraint = NSLayoutConstraint(item: maxLabel, attribute: .bottom, relatedBy: .equal, toItem: maxRecordLabel, attribute: .top, multiplier: 1.0, constant: -5.0)
        let leadingConstraint = NSLayoutConstraint(item: maxLabel, attribute: .leading, relatedBy: .equal, toItem: maxRecordLabel, attribute: .leading, multiplier: 1.0, constant: 0.0)
        
        return [bottomConstraint, leadingConstraint]
    }
    
    private func currentRecordLabelConstraint() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: currentRecordLabel, attribute: .top, relatedBy: .equal, toItem: maxRecordLabel, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: currentRecordLabel, attribute: .bottom, relatedBy: .equal, toItem: maxRecordLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: currentRecordLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -15.0)
        
        return [topConstraint, bottomConstraint, trailingConstraint]
    }
    
    private func startButtonConstraint() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: startButton, attribute: .top, relatedBy: .equal, toItem: playView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: startButton, attribute: .leading, relatedBy: .equal, toItem: playView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: startButton, attribute: .bottom, relatedBy: .equal, toItem: playView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: startButton, attribute: .trailing, relatedBy: .equal, toItem: playView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, bottomConstraint, trailingConstraint]
    }
    
    private func homeButtonConstraint() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: homeButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -45.0)
        let bottomConstraint = NSLayoutConstraint(item: homeButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: homeButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, bottomConstraint, leadingConstraint]
    }
    
    private func historyButtonConstraint() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: historyButton, attribute: .top, relatedBy: .equal, toItem: homeButton, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: historyButton, attribute: .bottom, relatedBy: .equal, toItem: homeButton, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: historyButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(item: historyButton, attribute: .width, relatedBy: .equal, toItem: homeButton, attribute: .width, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: historyButton, attribute: .leading, relatedBy: .equal, toItem: homeButton, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, bottomConstraint, trailingConstraint, widthConstraint, leadingConstraint]
    }
    
    private func gameButtonsStackViewConstraint() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: gameButtonsStackView, attribute: .top, relatedBy: .equal, toItem: playView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: gameButtonsStackView, attribute: .leading, relatedBy: .equal, toItem: playView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: gameButtonsStackView, attribute: .bottom, relatedBy: .equal, toItem: playView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: gameButtonsStackView, attribute: .trailing, relatedBy: .equal, toItem: playView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, bottomConstraint, trailingConstraint]
    }
}
