//
//  SearchViewController.swift
//  MoviesApp
//
//  Created by Ahmed on 8/17/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UISearchBarDelegate ,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var searchResults = [Results]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(!searchBar.text!.isEmpty){
            self.searchForMovieResults(name: searchBar.text!)
        } else {
            self.indicatorView.isHidden = true
            self.searchResults.removeAll()
            self.collectionView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(!searchText.isEmpty){
            self.searchForMovieResults(name: searchText)
        } else {
            self.indicatorView.isHidden = true
            self.searchResults.removeAll()
            self.collectionView.reloadData()
        }
    }
    
    
    func searchForMovieResults(name:String){
        self.indicatorView.isHidden = false
        APIClient().searchMovies(name: name, Success: {
            success,pages  in

            self.searchResults.removeAll()
            
            self.searchResults = success.results!
            
            self.indicatorView.isHidden = true
            
            self.collectionView.reloadData()
            
        }){ error in
            print(error)
            self.indicatorView.isHidden = true
            AlertHelper().showMessage(controller: self, title: "Opps!", msg: error)
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        
        cell.loadImage(searchResults[indexPath.row].poster_path ?? "")
        cell.title.text = searchResults[indexPath.row].title
        cell.subtitle.text = searchResults[indexPath.row].release_date
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.openDetails(id: searchResults[indexPath.row].id!)
    }
    
    func openDetails(id: Int){
        let nextVc = self.storyboard!.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        nextVc.movieID = String(id)
        
        self.present(nextVc, animated: true, completion: nil)
    }
    
}
