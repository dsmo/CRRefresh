//
//  CoinAnimator.swift
//  ZhiXinBao
//
//  Created by shiyu on 2018/12/11.
//  Copyright © 2018 zhirong. All rights reserved.
//

import UIKit

open class CoinAnimator: UIView, CRRefreshProtocol {
    
    static let circleDisappearAnimationDuration: CFTimeInterval = 0.1
    static let coinAppearAnimationDuration: CFTimeInterval = 0.4
    static let coinRotationAnimationDuration: CFTimeInterval = 0.3
    
    private lazy var animationLayer: CoinAnimationLayer = CoinAnimationLayer()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor(white: 0.625, alpha: 1.0)
        label.text = "廊坊银行资金存管"
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.addSublayer(animationLayer)
        addSubview(titleLabel)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.frame.size.width
        let height = self.frame.size.height
        let center = CGPoint(x: width / 2.0, y: height / 2.0)
        titleLabel.sizeToFit()
        titleLabel.center = center
        animationLayer.bounds = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
        animationLayer.position = CGPoint(x: titleLabel.frame.origin.x - 15.0, y: center.y)
        
        titleLabel.frame = titleLabel.frame.integral
        animationLayer.frame = animationLayer.frame.integral
    }
    
    // MARK: - CRRefreshProtocol
    
    open var view: UIView { return self }
    
    open var insets: UIEdgeInsets = .zero
    
    open var trigger: CGFloat = 55.0
    
    open var execute: CGFloat = 55.0
    
    open var endDelay: CGFloat = 0.7
    
    open var hold: CGFloat = 55.0
    
    /// 刷新进度的变化
    open func refresh(view: CRRefreshComponent, progressDidChange progress: CGFloat) {
        print("refresh progressDidChange:\(progress)")
        
        animationLayer.circleLayer.progress = Float(progress)
    }
    
    /// 开始刷新
    open func refreshBegin(view: CRRefreshComponent) {
        print("refreshBegin")
        
        animationLayer.circleLayer.startAnimation()
        animationLayer.coinLayer.startAnimation()
    }
    
    /// 即将结束刷新
    open func refreshWillEnd(view: CRRefreshComponent) {
        print("refreshWillEnd")
        
        animationLayer.coinLayer.endRotationAnimation().rotationAnimatnionDidEnd = { [weak checkLayer = animationLayer.checkLayer] in
            checkLayer?.startAnimation()
        }
    }
    
    /// 结束刷新
    open func refreshEnd(view: CRRefreshComponent, finish: Bool) {
        print("refreshEnd, finished: \(finish ? "true" : "false")")
        
        if finish {
            animationLayer.circleLayer.endAnimation()
            animationLayer.coinLayer.endAnimation()
            animationLayer.checkLayer.endAnimation()
        }
    }
    
    /// 刷新状态的变化
    open func refresh(view: CRRefreshComponent, stateDidChange state: CRRefreshState) {
        print("refresh stateDidChange:\(state)")
    }
    
}
