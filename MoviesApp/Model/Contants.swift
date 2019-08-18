//
//  URLS.swift
//  MoviesApp
//
//  Created by Ahmed on 8/13/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import Foundation

struct URLS {
    
    static let API_KEY = "e2ec881f72fb401340118b2f6d2c716d"
    
    static let baseURL = "https://api.themoviedb.org/3/"
    
    static let generate_Token = URLS.baseURL + "authentication/token/new?api_key=" + URLS.API_KEY
    
    static let loginURL = URLS.baseURL + "authentication/token/validate_with_login?api_key=" + URLS.API_KEY
    
    static let sessionURL = URLS.baseURL + "authentication/session/new?api_key=" + URLS.API_KEY
    
    static let profileURL = URLS.baseURL + "account?api_key=" + URLS.API_KEY + "&session_id="
    
    static let profileImageURL = "https://secure.gravatar.com/avatar/"
    
    static let topRated = URLS.baseURL + "movie/top_rated?api_key=" + URLS.API_KEY + "&language=en-US&page="
    
    static let nowPlaying = URLS.baseURL + "movie/now_playing?api_key=" + URLS.API_KEY + "&language=en-US&page="
    
    static let popular = URLS.baseURL + "movie/popular?api_key=" + URLS.API_KEY + "&language=en-US&page="
    
    static let upcoming = URLS.baseURL + "movie/upcoming?api_key=" + URLS.API_KEY + "&language=en-US&page="
    
    static let trendWeek = URLS.baseURL + "trending/movie/week?api_key=" + URLS.API_KEY
    
    static let trendDay = URLS.baseURL + "trending/movie/day?api_key=" + URLS.API_KEY
    
    static let search = URLS.baseURL + "search/movie?api_key=" + URLS.API_KEY + "&language=en-US&page=1&include_adult=false&query="
    
    static let ImagePath = "https://image.tmdb.org/t/p/w500"
    
    static let movieDetails = URLS.baseURL + "movie/"
    
    static let movieDetailsSec = "?api_key=" + URLS.API_KEY + "&language=en-US"
    
}
