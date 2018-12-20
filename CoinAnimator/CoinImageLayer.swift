//
//  CoinImageLayer.swift
//  ZhiXinBao
//
//  Created by shiyu on 2018/12/11.
//  Copyright © 2018 zhirong. All rights reserved.
//

import UIKit

class CoinImageLayer: CALayer {
    
    var rotationAnimatnionDidEnd: (() -> Void)?
    
    private var stopRotation = false
    
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
        contents = UIImage(named: "refresh_header_coin")?.cgImage
        opacity = 0.0
    }
    
    @discardableResult
    func startAnimation() -> Self {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.isRemovedOnCompletion = false
        scaleAnimation.fillMode = .forwards
        scaleAnimation.duration = CoinAnimator.coinAppearAnimationDuration
        scaleAnimation.fromValue = 0.1
        scaleAnimation.toValue = 1.0
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        add(scaleAnimation, forKey: "scaleAnimation")
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.isRemovedOnCompletion = false
        opacityAnimation.fillMode = .forwards
        opacityAnimation.duration = CoinAnimator.coinAppearAnimationDuration
        opacityAnimation.fromValue = 0.0
        opacityAnimation.toValue = 1.0
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        add(opacityAnimation, forKey: "opacityAnimation")
        
        addRotationAnimation(beginTime: convertTime(CACurrentMediaTime() + opacityAnimation.duration, from: nil))
        return self
    }
    
    private func addRotationAnimation(beginTime: CFTimeInterval) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotationAnimation.beginTime = beginTime
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * 2.0
        rotationAnimation.duration = CoinAnimator.coinRotationAnimationDuration
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        rotationAnimation.setValue("rotationAnimation", forKey: "Identifier")
        rotationAnimation.delegate = self
        
        add(rotationAnimation, forKey: nil)
    }
    
    @discardableResult
    func endRotationAnimation() -> Self {
        stopRotation = true
        return self
    }
    
    func endAnimation() {
        stopRotation = false
        removeAllAnimations()
    }
    
}

extension CoinImageLayer: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let identifier = anim.value(forKey: "Identifier") as? String {
            if identifier == "rotationAnimation" {
                if stopRotation {
                    rotationAnimatnionDidEnd?()
                } else {
                    addRotationAnimation(beginTime: 0)
                }
            }
        }
    }
    
}
