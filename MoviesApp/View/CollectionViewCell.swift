//
//  CollectionViewCell.swift
//  MoviesApp
//
//  Created by Ahmed on 8/14/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subtitle: UILabel!
    
    
    public func loadImage(_ path: String) {
        let url = URL(string: URLS.ImagePath + path)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url)
    }
    
}
