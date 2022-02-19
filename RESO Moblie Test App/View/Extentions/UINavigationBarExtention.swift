//
//  UINavigationBarExtention.swift
//  RESO Moblie Test App
//
//  Created by s b on 19.02.2022.
//

import UIKit

extension UIView {
    func setRadianGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.type = .radial
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.frame = bounds
        
       layer.insertSublayer(gradientLayer, at: 0)
    }
}
