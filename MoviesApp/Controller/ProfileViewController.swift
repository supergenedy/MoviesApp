//
//  ProfileViewController.swift
//  MoviesApp
//
//  Created by Ahmed on 8/18/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtUsername: UILabel!
    
    var token: String = ""
    var session: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        token = UserDefaults.standard.value(forKey: KEYS.TOKEN) as! String
        
        session = UserDefaults.standard.value(forKey: KEYS.SESSION) as! String
        
        makeImageRound()
        
        getUserProfile()
        
    }
    
    func makeImageRound(){
        userImage.layer.borderWidth = 1.0
        userImage.layer.masksToBounds = false
        userImage.layer.borderColor = UIColor.purple.cgColor
        userImage.layer.cornerRadius = userImage.frame.size.height/2
        userImage.clipsToBounds = true
    }
    
    @IBAction func whatchlist(_ sender: Any) {
        AlertHelper().showMessage(controller: self, title: "Sorry", msg: "This will be available soon")
    }
    
    @IBAction func favourites(_ sender: Any) {
        let nextVc = self.storyboard!.instantiateViewController(withIdentifier: "FavouritesViewController") as! FavouritesViewController
        
        self.present(UINavigationController(rootViewController: nextVc), animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        self.showLogoutAlert(title: "", msg: "Are you sure you want to Logout ?")
    }
    
    func getUserProfile(){
        if !session.isEmpty {
            if NetworkHelper.isConnectedToInternet {
                APIClient().getProfileDetails(sessionID: session , Success: {
                    success in
                    
                    self.txtName.text = success.name
                    self.txtUsername.text = success.username
                    
                    self.userImage.kf.indicatorType = .activity
                    self.userImage.kf.setImage(with: URL(string: URLS.profileImageURL + (success.avatar?.gravatar?.hash)! + ".jpg?s=64")!)
                    
                    
                }){ error in
                    self.showLogoutAlert(title: "Session Expired", msg: "Sorry the session has been expired, you have to login again")
                }
            } else {
                AlertHelper().showMessage(controller: self, title: "Oops!", msg: "Check you internet connection")
            }
        } else {
            self.showLogoutAlert(title: "Session Expired", msg: "Sorry the session has been expired, you have to logout and login again")
        }
    }
    
    func showLogoutAlert(title: String , msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Logout", style: .default, handler: {(action:UIAlertAction!) in
            self.logout()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert,animated: true, completion: nil)
    }
    
    func logout(){
        UserDefaults.standard.set("",forKey: KEYS.TOKEN)
        
        UserDefaults.standard.set("", forKey: KEYS.SESSION)
        
        UserDefaults.standard.set(false, forKey: KEYS.LOGGEDIN)
        
        self.goToSplashView()
    }
    
    func goToSplashView(){
        let splashViewController = self.storyboard?.instantiateViewController(withIdentifier: "SplashViewController")
        self.present(splashViewController!, animated: true, completion: nil)
    }

}
