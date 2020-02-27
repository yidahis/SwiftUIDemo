//
//  LockView.swift
//  手势解锁
//
//  Created by yidahis on 2020/1/29.
//  Copyright © 2020 fame.inc. All rights reserved.
//

import UIKit
protocol LockViewDelegate {
    func lockView(_ view: LockView, path: String, didFinished: Bool)
}

class LockView: UIView {
    private let pading: CGFloat = 10
    private let radius: CGFloat = 40
    private var currentPoint: CGPoint = CGPoint.zero
    private lazy var buttons: [UIButton] = {
       return [UIButton]()
    }()
    
    var delegate: LockViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configButtons()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configButtons()
    }
    
    private func configButtons(){
        self.backgroundColor = UIColor.init(red: 12/255.0, green: 12/255.0, blue: 144/255.0, alpha: 1)
        let space = (self.frame.width - 2 * pading - 2 * radius * 3)/2.0
        for i in 0..<3 {//行
            for j in 0..<3 {//列
                let btn = UIButton.init(type: .custom)
                btn.tag = i * 3 + j
                btn.isUserInteractionEnabled = false
                btn.setImage(UIImage(named: "gesture_node_normal"), for: .normal)
                btn.setImage(UIImage(named: "gesture_node_highlighted"), for: .selected)
                self.addSubview(btn)
                btn.frame = CGRect(x: pading + CGFloat(j)*space + 2 * radius * CGFloat(j),
                                   y: pading + CGFloat(i)*space + 2 * radius * CGFloat(i),
                                   width: 2 * radius,
                                   height: 2 * radius)
            }
        }
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension LockView {
    private func point(with touches: Set<UITouch>) -> CGPoint? {
        guard let touch = touches.first else {
            return nil
        }
        let point = touch.location(in: self)
        return point
    }
    
    private func button(with point: CGPoint) -> UIButton?{
        for btn in self.subviews {
            if let btn = btn as? UIButton, btn.frame.contains(point) {
                return btn
            }
        }
        return nil
    }
}

extension LockView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = point(with: touches), let btn = button(with: point) else {
            return
        }
        if btn.isSelected == false {
            btn.isSelected = true
            self.buttons.append(btn)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = point(with: touches) else {
            return
        }
        
        if let btn = button(with: point),btn.isSelected == false {
            btn.isSelected = true
            self.buttons.append(btn)
        }else {
            self.currentPoint = point
        }
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var path = ""
        self.buttons.forEach { (btn) in
            btn.isSelected = false
            path += String(btn.tag)
        }
        delegate?.lockView(self, path: path, didFinished: true)
        self.buttons.removeAll()
        self.setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchesEnded(touches, with: event)
    }
}

extension LockView {
    override func draw(_ rect: CGRect) {
        if self.buttons.count == 0 {
            return
        }
        let path = UIBezierPath()
        path.lineWidth = 8
        path.lineJoinStyle = .round
        UIColor.red.set()
        for i in 0..<buttons.count {
            let btn = buttons[i]
            if i == 0 {
                path.move(to: btn.center)
            }else{
                path.addLine(to: btn.center)
            }
        }
        path.addLine(to: self.currentPoint)
        path.stroke()
        
    }
}

