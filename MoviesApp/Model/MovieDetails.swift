//
//  MovieDetails.swift
//  MoviesApp
//
//  Created by Ahmed on 8/18/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import Foundation

struct MovieDetails: Codable {
    let backdrop_path: String?
    let genres: [Genres]?
    let overview: String?
    let poster_path: String?
    let release_date: String?
    let runtime: Int?
    let status: String?
    let title: String?
    let vote_average: Float?
    let status_message: String?
}

struct Genres: Codable {
    let name: String?
}
