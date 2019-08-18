//
//  DetailsViewController.swift
//  MoviesApp
//
//  Created by Ahmed on 8/18/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageBackDrop: UIImageView!
    @IBOutlet weak var imagePoster: CustomImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelRate: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelOverView: UILabel!
    
    var movieID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getMovieDetails()
    }

    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func getMovieDetails(){
        APIClient().movieDetails(id: movieID, Success: {
            success in
            
            self.imageBackDrop.kf.indicatorType = .activity
            self.imageBackDrop.kf.setImage(with: URL(string: URLS.ImagePath + success.backdrop_path!))
            
            self.imagePoster.kf.indicatorType = .activity
            self.imagePoster.kf.setImage(with: URL(string: URLS.ImagePath + success.poster_path!))
            
            self.labelTitle.text = success.title
            self.labelRate.text = success.vote_average!.description + "/10"
            self.labelGenre.text = success.genres![0].name
            self.labelOverView.text = success.overview
            
            
        }) { error in
            AlertHelper().showMessage(controller: self, title: "Oops!", msg: error)
        }
    }
    
}
