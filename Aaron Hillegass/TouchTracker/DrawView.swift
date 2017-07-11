//
//  DrawView.swift
//  TouchTracker
//
//  Created by JUN LEE on 2017. 7. 10..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class DrawView: UIView, UIGestureRecognizerDelegate {
    
    // MARK: Properites
    
    var currentLines = [NSValue:Line]()  // 현재 그리고 있는 선
    var finishedLines = [Line]()    // 그려진 선들의 집합
    var selectedLineIndex: Int? {
        // 선택한 선이 사라지게 되면 메뉴도 사라짐
        didSet {
            if selectedLineIndex == nil {
                let menu = UIMenuController.shared
                menu.setMenuVisible(false, animated: true)
            }
        }
    }
    var moveRecognizer: UIPanGestureRecognizer!
    
    @IBInspectable var finishedLineColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentLineColor: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineThickness: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: Initializer
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // double tap
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap(gestureRecognizer:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        addGestureRecognizer(doubleTapRecognizer)
        
        // single tap
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(gestureRecognizer:)))
        tapRecognizer.delaysTouchesBegan = true
        tapRecognizer.require(toFail: doubleTapRecognizer)
        addGestureRecognizer(tapRecognizer)
        
        // long press
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gestureRecognizer:)))
        addGestureRecognizer(longPressRecognizer)
        
        // pan
        moveRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveLine(gestureRecognizer:)))
        moveRecognizer.delegate = self
        moveRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(moveRecognizer)
    }
    
    // MARK: Gesture functions
    
    func doubleTap(gestureRecognizer: UIGestureRecognizer) {
        print("Recognized a double tap")
        
        selectedLineIndex = nil
        currentLines.removeAll(keepingCapacity: false)
        finishedLines.removeAll(keepingCapacity: false)
        
        setNeedsDisplay()
    }
    
    func tap(gestureRecognizer: UIGestureRecognizer) {
        print("Recognized a tap")
        
        let point = gestureRecognizer.location(in: self)
        selectedLineIndex = indexOfLineAtPoint(point: point)
        
        // 메뉴 컨트롤러를 얻는다
        let menu = UIMenuController.shared
        
        if selectedLineIndex != nil {
            
            // DrawView를 메뉴 아이템 액션 메시지의 타깃으로 만든다
            becomeFirstResponder()
            
            // "Delete" UIMenuItem을 만든다
            let deleteItem = UIMenuItem(title: "Delete", action: #selector(DrawView.deleteLine(sender:)))
            menu.menuItems = [deleteItem]
            
            // 메뉴가 나타날 영역을 정하고 그 위치에 보이게끔 설정한다
            menu.setTargetRect(CGRect(x: point.x, y: point.y, width: 2, height: 2), in: self)
            menu.setMenuVisible(true, animated: true)
        }
        else {
            // 선택된 선이 없다면 메뉴를 숨긴다
            menu.setMenuVisible(false, animated: true)
        }
        
        setNeedsDisplay()
    }
    
    func deleteLine(sender: AnyObject) {
        // finishedLines 목록에서 선택한 선을 제거한다
        if let index = selectedLineIndex {
            finishedLines.remove(at: index)
            selectedLineIndex = nil
            
            setNeedsDisplay()
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    func longPress(gestureRecognizer: UIGestureRecognizer) {
        print("Recognized a long press")
        
        if gestureRecognizer.state == .began {
            let point = gestureRecognizer.location(in: self)
            selectedLineIndex = indexOfLineAtPoint(point: point)
            
            if selectedLineIndex != nil {
                currentLines.removeAll(keepingCapacity: false)
            }
        }
        else if gestureRecognizer.state == .ended {
            selectedLineIndex = nil
        }
        
        setNeedsDisplay()
    }
    
    func moveLine(gestureRecognizer: UIPanGestureRecognizer) {
        
        // 선이 선택되면
        if let index = selectedLineIndex {
            print("selected Line Index = \(index)")
            // 팬 인식기의 위치가 변하면
            if gestureRecognizer.state == .changed {
                print("Recognized a pan")
                // 팬이 얼마나 움직였는지
                let translation = gestureRecognizer.translation(in: self)
                // 선의 현재 시작과 끝 지점에 이동 값을 더한다
                // 오타 없이 복사/붙여 넣기를 했는지 확인한다
                
                finishedLines[index].begin.x += translation.x
                finishedLines[index].begin.y += translation.y
                finishedLines[index].end.x += translation.x
                finishedLines[index].end.y += translation.y
                
                gestureRecognizer.setTranslation(CGPoint.zero, in: self)
                
                setNeedsDisplay()
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // MARK: Draw functions
    
    func strokeLine(line: Line) {
        let path = UIBezierPath()
//        path.lineWidth = 10
        path.lineWidth = lineThickness
        path.lineCapStyle = CGLineCap.round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        // 완성된 선은 검은색으로 그린다
//        UIColor.black.setStroke()
        
        finishedLineColor.setStroke()
        for line in finishedLines{
            strokeLine(line: line)
        }
        
//        UIColor.red.setStroke()
        
        currentLineColor.setStroke()
        for(_, line) in currentLines {
            strokeLine(line: line)
        }
        
        if let index = selectedLineIndex {
            UIColor.green.setStroke()
            let selectedLine = finishedLines[index]
            strokeLine(line: selectedLine)
        }
    }
    
    func indexOfLineAtPoint(point: CGPoint) -> Int? {
        // point와 가까운 선을 찾는다
        for (index, line) in finishedLines.enumerated() {
            let begin = line.begin
            let end = line.end
            
            // 선 위의 포인트를 검사한다
            for t in stride(from: CGFloat(0), to: 1.0, by: 0.05) {
                let x = begin.x + ((end.x - begin.x) * t)
                let y = begin.y + ((end.y - begin.y) * t)
                
                // 탭한 지점이 선과 20포인트 이내라면 이 선을 반환한다
                if hypot(x - point.x, y - point.y) < 20.0 {
                    return index
                }
            }
        }
        
        return nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        // 모든 터치를 하나하나 열거
        for touch in touches {
            let location = touch.location(in: self)
            
            let newLine = Line(begin: location, end: location)
            
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = newLine
        }
        
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = touch.location(in: self)
        }
        
        moveRecognizer.isEnabled = false
    
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key] {
                line.end = touch.location(in: self)
                
                finishedLines.append(line)
                currentLines.removeValue(forKey: key)
                
            }
        }
        
        moveRecognizer.isEnabled = true
        
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        currentLines.removeAll()
        
        setNeedsDisplay()
    }
}
