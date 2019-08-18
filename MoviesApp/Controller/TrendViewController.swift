//
//  TrendViewController.swift
//  MoviesApp
//
//  Created by Ahmed on 8/18/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import UIKit

class TrendViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var trendResults = [Results]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchForMovieResults(name: "day")

    }

    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.searchForMovieResults(name: "day")
            break
        case 1:
            self.searchForMovieResults(name: "week")
            break
        default:
            break
        }
    }
    
    
    func searchForMovieResults(name:String){
        APIClient().trendMovies(name: name, Success: {
            success,pages  in
            
            self.trendResults.removeAll()
            
            self.trendResults = success.results!
            
            self.collectionView.reloadData()
            self.collectionView.scrollsToTop = true

        }){ error in
            print(error)
            AlertHelper().showMessage(controller: self, title: "Opps!", msg: error)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        
        cell.loadImage(trendResults[indexPath.row].poster_path ?? "")
        cell.title.text = trendResults[indexPath.row].title
        cell.subtitle.text = trendResults[indexPath.row].release_date
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.openDetails(id: trendResults[indexPath.row].id!)
    }
    
    func openDetails(id: Int){
        let nextVc = self.storyboard!.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        nextVc.movieID = String(id)
        
        self.present(nextVc, animated: true, completion: nil)
    }
    
    
}
