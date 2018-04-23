//
//  CALayerExtension.swift
//  Dota
//
//  Created by Baran on 24.04.2018.
//  Copyright © 2018 CodingMind. All rights reserved.
//

import UIKit
extension CALayer {
    
    func addGradientLayer(size: CGSize, colors: [CGColor]){
        let gradientLayer : CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = size
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.name = "gradientLayer"
        self.addSublayer(gradientLayer)
    }
    
    func addVerticalGradientLayer(size: CGSize, colors: [CGColor]){
        let gradientLayer : CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = size
        gradientLayer.colors = colors
        gradientLayer.name = "gradientLayer"
        self.addSublayer(gradientLayer)
    }
    
    func removeGradientLayer(){
        if self.sublayers != nil {
            for layer in self.sublayers! {
                if layer.name == "gradientLayer" {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
    
}
