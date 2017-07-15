//
//  ViewController.swift
//  Quiz
//
//  Created by JUN LEE on 2017. 6. 30..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var answerLabel: UILabel!
    
    let questions: [String] = ["From what is cognac made?", "What is 7 + 7?", "What is the capital of Vermont?"]
    let answers: [String] = ["Grapes", "14", "Montpelier"]
    
    var currentQuestionIndex: Int = 0
    
    // MARK: Actions
    
    @IBAction func showNextQuestion(sender: AnyObject) {
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(sender: AnyObject) {
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }

    // MARK: Functions
    
    func animateLabelTransitions() {
        
        // 아직 처리하지 않은 레이아웃 변경을 요구한다
        view.layoutIfNeeded()
        
        // 알파 값을 변경한다
        // 그리고 center X 제약 조건을 추가한다
        
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear], animations: {
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
            
            self.view.layoutIfNeeded()
        }, completion: {
            _ in
            swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
            swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
            
            self.updateOffScreenLabel()
        })
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 라벨의 초기 알파 값을 설정한다
        nextQuestionLabel.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let question = questions[currentQuestionIndex]
        currentQuestionLabel.text = question
        
        updateOffScreenLabel()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

