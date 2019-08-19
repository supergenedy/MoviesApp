//
//  LoginViewController.swift
//  MoviesApp
//
//  Created by Ahmed on 8/13/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet weak var signupButton: UIButton!
    
    var token = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshToken()
        
    }
    
    
    @IBAction func login(_ sender: Any) {
        if !token.isEmpty {
            if !usernameField.text!.isEmpty {
                if !passwordField.text!.isEmpty {
                    self.loginUser(userName: usernameField.text!, passwrod: passwordField.text!, token: token)
                } else {
                    AlertHelper().showMessage(controller: self, title: "Oops!", msg: "Please enter your Password")
                }
            } else {
               AlertHelper().showMessage(controller: self, title: "Oops!", msg: "Please enter your Username")
            }
        } else {
            self.refreshToken()
            AlertHelper().showMessage(controller: self, title: "Oops!", msg: "Please try again")
        }
    }
    
    @IBAction func signupClicked(_ sender: Any) {
        guard let url = URL(string: URLS.signupURL) else { return }
        UIApplication.shared.open(url)
    }
    
    func refreshToken(){
        APIClient().generateToken(Success: {
            success in
            
            if let newToken = success.request_token {
                
                UserDefaults.standard.set(newToken, forKey: KEYS.TOKEN)
                
                self.token = newToken
            }
        }) { error in
            AlertHelper().showMessage(controller:self,title: "Error", msg: error)
        }
    }
    
    func createNewSession(token:String){
        APIClient().createSession(token: token,Success: {
            success in
            
            if let session = success.session_id {
                print(session)
                
                UserDefaults.standard.set(token,forKey: KEYS.TOKEN)
                
                UserDefaults.standard.set(session, forKey: KEYS.SESSION)
                
                UserDefaults.standard.set(true, forKey: KEYS.LOGGEDIN)
                
                self.goToNextView()
            }
        }) {
            error in
            AlertHelper().showMessage(controller:self,title: "Error", msg: error)
        }
    }
    
    func loginUser(userName: String, passwrod: String, token: String){
        if NetworkHelper.isConnectedToInternet {
            
            APIClient().login(username: userName, password: passwrod, token: token, Success:{
                success in
                if let token = success.request_token {
                    
                    self.createNewSession(token: token)
                }
            }) { error in
                AlertHelper().showMessage(controller: self, title: "Error", msg: error)
            }
        } else {
            AlertHelper().showMessage(controller: self, title: "Oops!", msg: "Check your internet connection")
        }
    }
    
    func goToNextView(){
        let tabViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabViewController")
        self.present(tabViewController!, animated: true, completion: nil)
    }
    
    
}
