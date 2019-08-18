//
//  CustomBackground.swift
//  MoviesApp
//
//  Created by Ahmed on 8/14/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import Foundation
import UIKit

class CustomBackground: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.applyGradient()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.applyGradient()
    }
    
    
    func applyGradient(){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.purple,UIColor.orange].map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
}
