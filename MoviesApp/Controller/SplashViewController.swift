//
//  ViewController.swift
//  MoviesApp
//
//  Created by Ahmed on 8/13/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            
        if UserDefaults.standard.bool(forKey: KEYS.LOGGEDIN){
            self.checkSession()
        } else {
            self.requestToken()
        }
    }

    func checkSession(){
        
        if UserDefaults.standard.value(forKey: KEYS.SESSION) != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    self.goToHomeView()
                })
        } else {
            AlertHelper().showMessage(controller: self,title: "Error", msg: "Session Expired")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.goToLoginView()
            })
        }
    }
    
    func requestToken(){
        if NetworkHelper.isConnectedToInternet {
            APIClient().generateToken(Success: {
                success in
                
                if let token = success.request_token {
                    
                    UserDefaults.standard.set(token, forKey: KEYS.TOKEN)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        self.goToLoginView()
                    })
                    
                }
            }) {
                error in
                AlertHelper().showMessage(controller: self,title: "Error", msg: error)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    self.goToLoginView()
                })
            }
        }else {
            AlertHelper().showMessage(controller: self,title: "Oops!", msg: "Check your internet connection")
        }
        
    }
    
    func goToLoginView(){
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        if let presented = self.presentedViewController {
            presented.present(loginViewController!, animated: true, completion: nil)
        } else {
            self.present(loginViewController!, animated: true, completion: nil)
        }
    }
    
    func goToHomeView(){
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabViewController")
        if let presented = self.presentedViewController {
            presented.present(homeViewController!, animated: true, completion: nil)
        } else {
            self.present(homeViewController!, animated: true, completion: nil)
        }
    }
}

