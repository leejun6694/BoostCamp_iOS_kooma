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
    
    var recordStore: RecordStore!
    
    private lazy var homeLabel: UILabel = {
        let homeLabel = UILabel()
        let RGBpoint:CGFloat = 255.0
        
        homeLabel.text = "1 to 25"
        homeLabel.textColor = UIColor(red: 111.0/RGBpoint, green: 167.0/RGBpoint, blue: 145.0/RGBpoint, alpha: 1.0)
        homeLabel.textAlignment = .center
        homeLabel.font = UIFont(name: homeLabel.font.fontName, size: 60.0)
        homeLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        homeLabel.translatesAutoresizingMaskIntoConstraints = false
    
        return homeLabel
    }()
    
    private lazy var playButton: UIButton = {
        let playButton = UIButton(type: .system)
        let RGBpoint:CGFloat = 255.0
        
        playButton.setTitle("PLAY", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        playButton.backgroundColor = UIColor(red: 220.0/RGBpoint, green: 104.0/RGBpoint, blue: 80.0/RGBpoint, alpha: 1.0)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        playButton.addTarget(self, action: #selector(clickPlayButton(_:)), for: .touchUpInside)
        
        return playButton
    }()
    
    private lazy var historyButton: UIButton = {
        let historyButton = UIButton(type: .system)
        let RGBpoint:CGFloat = 255.0

        historyButton.setTitle("HISTORY", for: .normal)
        historyButton.setTitleColor(.white, for: .normal)
        historyButton.backgroundColor = UIColor(red: 220.0/RGBpoint, green: 104.0/RGBpoint, blue: 80.0/RGBpoint, alpha: 1.0)
        historyButton.translatesAutoresizingMaskIntoConstraints = false

        historyButton.addTarget(self, action: #selector(clickHistoryButton(_:)), for: .touchUpInside)
        
        return historyButton
    }()
    
    // MARK: Action
    
    func clickPlayButton(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "segueFromStartToPlay", sender: self)
    }
    
    func clickHistoryButton(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "segueFromStartToHistory", sender: self)
    }
    
    // MARK: Animation
    
    func animateHomeLabel() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.curveEaseIn, .repeat, .autoreverse],
                       animations: {
                        self.homeLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        })
    }
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(homeLabel)
        view.addSubview(playButton)
        view.addSubview(historyButton)
        
        view.addConstraints(homeLabelConstraints())
        view.addConstraints(playButtonConstraints())
        view.addConstraints(historyButtonConstraints())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animateHomeLabel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        homeLabel.transform = .identity
    }
    
    /* 화면이 사라지면 애니메이션도 중지해야 합니다! 화면이 없는데, 애니메이션을 실행하고 있는 것은 낭비지요! 스레드 문제를 일으킬 수도 있습니다 */
    /* 실행해 보면 알겠지만, 다른화면으로 넘어간 후에 뭔가 문제가 생깁니다. 고려해봐야 할 문제가 있습니다! */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFromStartToPlay" {
            let destinationController = segue.destination as! PlayViewController
            destinationController.recordStore = self.recordStore
        }
        else if segue.identifier == "segueFromStartToHistory" {
            let destinationController = segue.destination as! HistoryViewController
            destinationController.recordStore = self.recordStore
        }
    }
    
    // MARK: Constraint
    
    private func homeLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: homeLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: homeLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 10.0)
        let trailingConstraint = NSLayoutConstraint(item: homeLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -10.0)
        let heightConstraint = NSLayoutConstraint(item: homeLabel, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.3, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, heightConstraint]
    }
    
    private func playButtonConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(item: playButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: playButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 10.0)
        let heightConstraint = NSLayoutConstraint(item: playButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.3, constant: 0.0)
        
        return [centerYConstraint, leadingConstraint, heightConstraint]
    }
    
    private func historyButtonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: historyButton, attribute: .top, relatedBy: .equal, toItem: playButton, attribute: .top, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: historyButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -10.0)
        let heightConstraint = NSLayoutConstraint(item: historyButton, attribute: .height, relatedBy: .equal, toItem: playButton, attribute: .height, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(item: historyButton, attribute: .width, relatedBy: .equal, toItem: playButton, attribute: .width, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: historyButton, attribute: .leading, relatedBy: .equal, toItem: playButton, attribute: .trailing, multiplier: 1.0, constant: 8.0)
        
        return [topConstraint, trailingConstraint, heightConstraint, widthConstraint, leadingConstraint]
    }
}
