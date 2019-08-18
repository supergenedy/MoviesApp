//
//  APIClient.swift
//  MoviesApp
//
//  Created by Ahmed on 8/13/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    
    // Generate Token
    func generateToken(Success: @escaping (_ object: Token)-> Void, Error: @escaping (_ error: String)-> Void){
        
        Alamofire.request(URL(string: URLS.generate_Token)!).responseJSON { response in
            do{
                let JSON = try JSONDecoder().decode(Token.self, from: response.data!)
                if JSON.request_token != nil {
                    Success(JSON)
                }else {
                    Error(JSON.status_message!)
                }
            }catch{
                Error(error.localizedDescription)
            }
        }
    }
    
    func createSession(token: String, Success: @escaping (_ object: Session)-> Void, Error: @escaping (_ error: String)-> Void){
        
        let header = ["content-type": "application/json"]
        let parameter = ["request_token": token]
        
        
        Alamofire.request(URL(string: URLS.sessionURL)!, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            do{
                let JSON = try JSONDecoder().decode(Session.self, from: response.data!)
                if JSON.session_id != nil {
                    Success(JSON)
                }else{
                    Error(JSON.status_message!)
                }
            }catch{
                Error(error.localizedDescription)
            }
        }
    }
    
    //Login
    func login(username:String,password:String,token:String, Success: @escaping (_ success: Login)-> Void, Error: @escaping (_ error: String)-> Void){
        
        let header = ["content-type": "application/json"]
        let parameters = [
            "username": username,
            "password": password,
            "request_token": token
        ]
        Alamofire.request(URL(string: URLS.loginURL)!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            do{
                let JSON = try JSONDecoder().decode(Login.self, from: response.data!)
                if let token = JSON.request_token {
                    UserDefaults.standard.set(token, forKey: KEYS.TOKEN)
                    Success(JSON)
                }else {
                    Error(JSON.status_message!)
                }
            }catch{
                Error(error.localizedDescription)
            }
        }
    }
    
    // Getting profile details
    func getProfileDetails(sessionID: String, Success: @escaping (_ object: Profile)-> Void, Error: @escaping (_ error: String)-> Void){
        
        let url = URLS.profileURL + sessionID
        
        Alamofire.request(url).responseJSON { response in
            
            do{
                let JSON = try JSONDecoder().decode(Profile.self, from: response.data!)
                
                if JSON.id != nil {
                    Success(JSON)
                }else {
                    Error(JSON.status_message!)
                }
            }catch{
                Error(error.localizedDescription)
            }
        }
    }
    
    
    func moviesList(url:String,_ page: Int = 1, Success: @escaping (_ object: Movie, _ totalPages: Int)-> Void, Error: @escaping (_ error: String)-> Void){
        let url = URL(string: url + String(page))
        
        Alamofire.request(url ?? "").responseJSON { response in
            
            do{
                let JSON = try JSONDecoder().decode(Movie.self, from: response.data!)
                if let total = JSON.total_pages{
                    Success(JSON, total)
                }else {
                    Error("No Movies Found")
                }
            }catch{
                Error(error.localizedDescription)
            }
        }
    }
    
    
    func searchMovies(name:String, Success: @escaping (_ object: Movie, _ totalPages: Int)-> Void, Error: @escaping (_ error: String)-> Void){
        
        let url : String = URLS.search + name
        
        let urlStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! as String
        
        Alamofire.request(URL(string: urlStr) ?? "").responseJSON { response in
            
            do{
                let JSON = try JSONDecoder().decode(Movie.self, from: response.data!)
                if let total = JSON.total_pages{
                    Success(JSON, total)
                }else {
                    Error("No Movies Found")
                }
            }catch{
                Error(error.localizedDescription)
            }
        }
    }
    
    func trendMovies(name:String, Success: @escaping (_ object: Movie, _ totalPages: Int)-> Void, Error: @escaping (_ error: String)-> Void){
        
        var url = URL(string: URLS.trendDay)
        
        if name == "week" {
            url = URL(string: URLS.trendWeek)
        }
        
        Alamofire.request(url!).responseJSON { response in
            
            do{
                let JSON = try JSONDecoder().decode(Movie.self, from: response.data!)
                if let total = JSON.total_pages{
                    Success(JSON, total)
                }else {
                    Error("No Movies Found")
                }
            }catch{
                Error(error.localizedDescription)
            }
        }
    }
    
    
    func movieDetails(id: String, Success: @escaping (_ object: MovieDetails)-> Void, Error: @escaping (_ error: String)-> Void){
        
        let url = URL(string: URLS.movieDetails + id + URLS.movieDetailsSec)
        Alamofire.request(url!).responseJSON { response in
            do{
                let JSON = try JSONDecoder().decode(MovieDetails.self, from: response.data!)
                if JSON.status_message == nil{
                    Success(JSON)
                } else {
                    Error(JSON.status_message!)
                }
            }catch{
                Error(error.localizedDescription)
            }
        }
    }
    
}
