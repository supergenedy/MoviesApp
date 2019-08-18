//
//  NetworkHelper.swift
//  MoviesApp
//
//  Created by Ahmed on 8/13/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import Foundation
import Alamofire

class NetworkHelper {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
