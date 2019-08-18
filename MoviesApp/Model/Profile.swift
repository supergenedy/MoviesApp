//
//  Profile.swift
//  MoviesApp
//
//  Created by Ahmed on 8/14/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import Foundation

struct Profile: Codable {
    let avatar: Avatar?
    let id: Int?
    let name: String?
    let username: String?
    let status_message: String?
}

struct Avatar: Codable {
    let gravatar: Gravatar?
}

struct Gravatar: Codable {
    let hash: String?
}
