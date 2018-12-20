//
//  CoinAnimationLayer.swift
//  ZhiXinBao
//
//  Created by shiyu on 2018/12/11.
//  Copyright © 2018 zhirong. All rights reserved.
//

import UIKit

class CoinAnimationLayer: CALayer {
    
    lazy var circleLayer: CoinCircleLayer = CoinCircleLayer()
    lazy var coinLayer: CoinImageLayer = CoinImageLayer()
    lazy var checkLayer: CoinCheckLayer = CoinCheckLayer()
    
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
        addCircleLayer()
        addCoinLayer()
        addCheckLayer()
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()
        layoutCircleLayer(frame: bounds)
        layoutCoinLayer(frame: bounds)
        layoutCheckLayer(frame: bounds)
    }
    
    private func addCircleLayer() {
        addSublayer(circleLayer)
    }
    
    private func layoutCircleLayer(frame: CGRect) {
        circleLayer.frame = frame
    }
    
    private func addCoinLayer() {
        addSublayer(coinLayer)
    }
    
    private func layoutCoinLayer(frame: CGRect) {
        coinLayer.frame = frame
    }
    
    private func addCheckLayer() {
        addSublayer(checkLayer)
    }
    
    private func layoutCheckLayer(frame: CGRect) {
        checkLayer.frame = frame
    }
    
}
