//
//  CustomImageView.swift
//  MoviesApp
//
//  Created by Ahmed on 8/14/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import Foundation
import UIKit

class CustomImageView : UIImageView {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    func setup(){
        setShadow()
//        self.clipsToBounds = true
        self.layer.cornerRadius = 15
    }
    
    
    func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
    
    }
    
    
}
