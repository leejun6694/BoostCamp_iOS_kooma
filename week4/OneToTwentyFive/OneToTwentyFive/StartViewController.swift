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
    
    // 프로퍼티의 초기화에 관해서 레몬님 코멘트를 참고해보아요
    let homeLabel: UILabel! = UILabel()
    let playButton: UIButton! = UIButton(type: .system)
    let historyButton: UIButton! = UIButton(type: .system)
    let RGBpoint:CGFloat = 255.0
    
    var recordStore: RecordStore!
    
    // MARK: Draw
    // 접근지정자 생각해보기
    func createHomeLabel() {
        homeLabel.text = "1 to 25"
        homeLabel.textColor = UIColor(red: 111.0/RGBpoint, green: 167.0/RGBpoint, blue: 145.0/RGBpoint, alpha: 1.0)
        homeLabel.textAlignment = .center
        homeLabel.font = UIFont(name: homeLabel.font.fontName, size: 60.0)
        homeLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        self.view.addSubview(homeLabel)
        
        homeLabel.translatesAutoresizingMaskIntoConstraints = false
        homeLabel.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        homeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10.0).isActive = true
        homeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10.0).isActive = true
        homeLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    func createPlayButton() {
        playButton.setTitle("PLAY", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        playButton.backgroundColor = UIColor(red: 220.0/RGBpoint, green: 104.0/RGBpoint, blue: 80.0/RGBpoint, alpha: 1.0)
        self.view.addSubview(playButton)
        
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        playButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10.0).isActive = true
        playButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
        
        playButton.addTarget(self, action: #selector(clickPlayButton(_:)), for: .touchUpInside)
    }
    
    func createHistoryButton() {
        historyButton.setTitle("HISTORY", for: .normal)
        historyButton.setTitleColor(.white, for: .normal)
        historyButton.backgroundColor = UIColor(red: 220.0/RGBpoint, green: 104.0/RGBpoint, blue: 80.0/RGBpoint, alpha: 1.0)
        self.view.addSubview(historyButton)
        
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        historyButton.topAnchor.constraint(equalTo: playButton.topAnchor).isActive = true
        historyButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10.0).isActive = true
        historyButton.heightAnchor.constraint(equalTo: playButton.heightAnchor).isActive = true
        historyButton.widthAnchor.constraint(equalTo: playButton.widthAnchor).isActive = true
        historyButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 8.0).isActive = true
        
        historyButton.addTarget(self, action: #selector(clickHistoryButton(_:)), for: .touchUpInside)
    }
    
    func updateView() {
        createHomeLabel()
        createPlayButton()
        createHistoryButton()
    }
    
    // MARK: Animation
    
    func animateSmallHomeLabel() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.curveEaseOut],
                       animations: {
                        self.homeLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }, completion: { _ in
            self.animateBigHomeLabel()
        })
    }
    
    func animateBigHomeLabel() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.curveEaseOut],
                       animations: {
                        self.homeLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: { _ in
            self.animateSmallHomeLabel()
        })
    }
    
    // MARK: Action
    
    func clickPlayButton(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "segueFromStartToPlay", sender: self)
    }
    
    func clickHistoryButton(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "segueFromStartToHistory", sender: self)
    }
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        animateSmallHomeLabel()
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
}
