//
//  CustomButtom.swift
//  MoviesApp
//
//  Created by Ahmed on 8/13/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import Foundation
import UIKit

class CustomButton : UIButton {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        setShadow()
        self.applyGradient(colours: [UIColor.orange,UIColor.purple])

        self.clipsToBounds = true
        self.layer.cornerRadius = 15
        
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont(name: "Arial", size: 18)
        
    }
    
    func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.5
        
    }

    func applyGradient(colours: [UIColor]) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
}
