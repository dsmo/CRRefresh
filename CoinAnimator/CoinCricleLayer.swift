//
//  CoinCircleLayer.swift
//  ZhiXinBao
//
//  Created by shiyu on 2018/12/11.
//  Copyright © 2018 zhirong. All rights reserved.
//

import UIKit

class CoinCircleLayer: CALayer {
    
    var progress: Float = 0.0 {
        didSet {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            let realProgress = min(max(0.0, (progress - 0.5) / 0.5), 1.0)
            circleShape.strokeEnd = CGFloat(realProgress)
            CATransaction.commit()
            
            if #available(iOS 10.0, *) {
                if realProgress >= 1.0 && oldValue < 1.0 {
                    let feedback = UIImpactFeedbackGenerator(style: .light)
                    feedback.impactOccurred()
                }
            }
        }
    }
    
    private lazy var circleGradient = CAGradientLayer()
    private lazy var circleShape = CAShapeLayer()
    
    override init() {
        super.init()
        commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commomInit()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    private func commomInit() {
        addCircleGradient()
        maskCircleGradient()
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()
        layoutCircleGradient(frame: bounds)
        layoutCircleShape(frame: bounds)
    }
    
    private func addCircleGradient() {
        circleGradient.colors = [UIColor.yellow.cgColor, UIColor.red.cgColor]
        circleGradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        circleGradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        addSublayer(circleGradient)
    }
    
    private func layoutCircleGradient(frame: CGRect) {
        circleGradient.frame = frame
    }
    
    private func maskCircleGradient() {
        circleShape.lineCap = .round
        circleShape.lineWidth = 3.0
        circleShape.strokeColor = UIColor.red.cgColor
        circleShape.fillColor = UIColor.clear.cgColor
        circleShape.strokeEnd = 0.0
        circleGradient.mask = circleShape
    }
    
    private func layoutCircleShape(frame: CGRect) {
        circleShape.frame = frame
        let width = frame.size.width
        let height = frame.size.height
        
        let radius = min(width, height) * 0.5 - circleShape.lineWidth * 0.5
        let center = CGPoint(x: width / 2.0, y: height / 2.0)
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        circleShape.path = path.cgPath
    }
    
    func startAnimation() {
        let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
        fadeOutAnimation.isRemovedOnCompletion = false
        fadeOutAnimation.fromValue = 1.0
        fadeOutAnimation.toValue = 0.0
        fadeOutAnimation.duration = CoinAnimator.circleDisappearAnimationDuration
        let diff = CoinAnimator.coinAppearAnimationDuration - CoinAnimator.circleDisappearAnimationDuration
        fadeOutAnimation.beginTime = convertTime(CACurrentMediaTime() + diff, from: nil)
        fadeOutAnimation.fillMode = .forwards
        add(fadeOutAnimation, forKey: nil)
    }
    
    func endAnimation() {
        removeAllAnimations()
    }
    
}
