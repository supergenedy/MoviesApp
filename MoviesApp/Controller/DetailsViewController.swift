//
//  DetailsViewController.swift
//  MoviesApp
//
//  Created by Ahmed on 8/18/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

class DetailsViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var dataController: DataController!
    var fetchedResultsController : NSFetchedResultsController<MovieItem>!

    @IBOutlet weak var imageBackDrop: UIImageView!
    @IBOutlet weak var imagePoster: CustomImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelRate: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelOverView: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    var movieID: String = ""
    
    var movieDetails: MovieDetails!
    
    var fetchedMovie: MovieItem!
    var movieIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        dataController = appDelegate.dataController
        
        setupFetchedResultsController()
        
        if NetworkHelper.isConnectedToInternet {
            getMovieDetails()
        }else {
            if fetchedMovie != nil {
                self.setMovieDetails(title: fetchedMovie.title!,overview: fetchedMovie.overview!,vote_average: fetchedMovie.vote_average,genresName: fetchedMovie.genre!,backdrop_path: fetchedMovie.backdrop_path!,poster_path: fetchedMovie.poster_path!)
            }
            AlertHelper().showMessage(controller: self, title: "Oops!", msg: "No Internet connection")
        }
    }

    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func favClicked(_ sender: Any) {
        if favButton.currentImage == UIImage(named: "heart-out"){
            self.addMovie()
        } else if favButton.currentImage == UIImage(named: "heart-filled") {
            self.removeMovie()
        }
    }
    
    func setupFetchedResultsController(){
        let fetchRequest : NSFetchRequest<MovieItem> = MovieItem.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "favs")
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch  {
            fatalError(error.localizedDescription)
        }
        
        for (index , movie) in fetchedResultsController.fetchedObjects!.enumerated() {
            if Int(movieID) == Int(movie.id){
                movieIndex = index
                fetchedMovie = movie
                markAsFav()
            }
        }
    }
    
    
    func getMovieDetails(){
        APIClient().movieDetails(id: movieID, Success: {
            success in
            
            self.movieDetails = success
            
            self.setMovieDetails(title: success.title!,overview: success.overview!,vote_average: success.vote_average!,genresName: success.genres![0].name!,backdrop_path: success.backdrop_path!,poster_path: success.poster_path!)
            
        }) { error in
            AlertHelper().showMessage(controller: self, title: "Oops!", msg: error)
        }
    }
    
    func setMovieDetails(title: String, overview: String, vote_average: Float, genresName: String, backdrop_path: String, poster_path: String){
        self.imageBackDrop.kf.indicatorType = .activity
        self.imageBackDrop.kf.setImage(with: URL(string: URLS.ImagePath + backdrop_path))
        
        self.imagePoster.kf.indicatorType = .activity
        self.imagePoster.kf.setImage(with: URL(string: URLS.ImagePath + poster_path))
        
        self.labelTitle.text = title
        self.labelRate.text = vote_average.description + "/10"
        self.labelGenre.text = genresName
        self.labelOverView.text = overview
        
    }
    
    func markAsFav(){
        print("Marked fav")
        self.favButton.setImage(UIImage(named: "heart-filled"), for: .normal)
    }
    
    func markAsUnFav(){
        print("unMarked fav")
        self.favButton.setImage(UIImage(named: "heart-out"), for: .normal)
    }
    
    func addMovie(){
        let movie = MovieItem(context: dataController.viewContext)
        movie.id = Int32(self.movieID)!
        movie.title = self.movieDetails.title ?? ""
        movie.overview = self.movieDetails.overview ?? ""
        movie.backdrop_path = self.movieDetails.backdrop_path ?? ""
        movie.poster_path = self.movieDetails.poster_path ?? ""
        movie.release_date = self.movieDetails.release_date ?? ""
        movie.runtime = Int32(self.movieDetails.runtime ?? 00)
        movie.status = self.movieDetails.status ?? ""
        movie.vote_average = self.movieDetails.vote_average ?? 0.0
        movie.genre = self.movieDetails.genres![0].name ?? ""
        
        print(movie.id," added")
        
        try? dataController.viewContext.save()
    }
    
    func removeMovie(){
        if(movieIndex != nil) {
            dataController.viewContext.delete(
                fetchedResultsController.fetchedObjects![movieIndex])
            print(fetchedResultsController.fetchedObjects![movieIndex].id," removed")
            movieIndex = nil
            try? dataController.viewContext.save()
        }
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        print(type)
        switch type {
        case .insert:
            markAsFav()
            break
        case .delete:
            markAsUnFav()
            break
        case .update:
            break
        case .move:
            break
        @unknown default:
            break
        }
    }
    
}
