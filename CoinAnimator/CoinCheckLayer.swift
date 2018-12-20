//
//  CoinCheckLayer.swift
//  ZhiXinBao
//
//  Created by shiyu on 2018/12/11.
//  Copyright © 2018 zhirong. All rights reserved.
//

import UIKit

class CoinCheckLayer: CALayer {
    
    static let backgroundAppearAnimationDuration: CFTimeInterval = 0.2
    static let checkStrokStartAnimationDuration: CFTimeInterval = 0.4
    
    private lazy var background: CAShapeLayer = CAShapeLayer()
    private lazy var check: CAShapeLayer = CAShapeLayer()
    
    let lineWidth: CGFloat = 2.5
    let backColor = UIColor(red: 255.0 / 255.0, green: 208.0 / 255.0, blue: 0.0, alpha: 1.0)
    let lineColor = UIColor.white
    
    override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    private func commonInit() {
        backgroundColor = UIColor.clear.cgColor
        addBackgroundLayer()
        addCheckLayer()
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()
        layoutCheckLayer(frame: bounds)
        layoutBackgroundLayer(frame: bounds)
    }
    
    private func addCheckLayer() {
        check.lineCap = CAShapeLayerLineCap.round
        check.lineJoin = CAShapeLayerLineJoin.round
        check.lineWidth = lineWidth
        check.fillColor = UIColor.clear.cgColor
        check.strokeColor = lineColor.cgColor
        check.strokeStart = 0
        check.strokeEnd = 0
        addSublayer(check)
    }
    
    private func layoutCheckLayer(frame: CGRect) {
        let width = Double(frame.size.width)
        let path = UIBezierPath()
        let a = sin(0.4) * (width/2)
        let b = cos(0.4) * (width/2)
        path.move(to: CGPoint(x: width/2 - b, y: width/2 - a))
        path.addLine(to: CGPoint(x: width/2 - width/20 , y: width/2 + width/8))
        path.addLine(to: CGPoint(x: width - width/5, y: width/2 - a))
        check.path = path.cgPath
    }
    
    private func addBackgroundLayer() {
        background.fillColor = backColor.cgColor
        background.opacity = 0.0
        addSublayer(background)
    }
    
    private func layoutBackgroundLayer(frame: CGRect) {
        let path = UIBezierPath(ovalIn: CGRect(origin: .zero, size: frame.size))
        background.path = path.cgPath
    }
    
    func startAnimation() {
        let backgroundAnimation = CABasicAnimation(keyPath: "opacity")
        backgroundAnimation.isRemovedOnCompletion = false
        backgroundAnimation.fillMode = .forwards
        backgroundAnimation.duration = CoinCheckLayer.backgroundAppearAnimationDuration
        backgroundAnimation.fromValue = 0.0
        backgroundAnimation.toValue = 1.0
        backgroundAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        background.add(backgroundAnimation, forKey: nil)
        
        let start = CAKeyframeAnimation(keyPath: "strokeStart")
        start.values = [0, 0.4, 0.3]
        start.isRemovedOnCompletion = false
        start.fillMode = CAMediaTimingFillMode.forwards
        start.duration = CoinCheckLayer.checkStrokStartAnimationDuration
        start.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        let end = CAKeyframeAnimation(keyPath: "strokeEnd")
        end.values = [0, 0.95, 0.9]
        
        end.isRemovedOnCompletion = false
        end.fillMode = CAMediaTimingFillMode.forwards
        end.duration = CoinCheckLayer.checkStrokStartAnimationDuration + 0.3
        end.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        check.add(start, forKey: "start")
        check.add(end, forKey: "end")
    }
    
    func endAnimation() {
        background.removeAllAnimations()
        check.removeAllAnimations()
    }
    
}
