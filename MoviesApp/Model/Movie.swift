//
//  TopRated.swift
//  MoviesApp
//
//  Created by Ahmed on 8/14/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let page : Int?
    let total_pages : Int?
    let results : [Results]?
}

struct Results: Codable {
    let id: Int?
    let vote_average: Float?
    let title: String?
    let poster_path: String?
    let overview: String?
    let release_date: String?
}
