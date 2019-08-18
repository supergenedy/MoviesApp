//
//  AlertHelper.swift
//  MoviesApp
//
//  Created by Ahmed on 8/13/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import Foundation
import UIKit

class AlertHelper {
    
    func showMessage(controller: UIViewController ,title: String , msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        controller.present(alert,animated: true, completion: nil)
    }
}
