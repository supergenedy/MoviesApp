//
//  HomeViewController.swift
//  MoviesApp
//
//  Created by Ahmed on 8/14/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var topRate = [Results]()
    var nowPlaying = [Results]()
    var populer = [Results]()
    var upcoming = [Results]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getMoviesData()
        
    }
    
    
    func getMoviesData(){
        APIClient().moviesList(url: URLS.topRated, 1, Success: {
            success,pages  in
            self.topRate = success.results!
        
            APIClient().moviesList(url: URLS.popular, 1, Success: {
                success,pages  in
                self.populer = success.results!
                
                APIClient().moviesList(url: URLS.nowPlaying, 1, Success: {
                    success,pages  in
                    self.nowPlaying = success.results!
                    
                    APIClient().moviesList(url: URLS.upcoming, 1, Success: {
                        success,pages  in
                        
                        self.upcoming = success.results!
                        
                        self.tableView.reloadData()
                        
                    }){ error in
                        print(error)
                    }
                    
                }){ error in
                    print(error)
                }
                
            }){ error in
                print(error)
            }
            
        }){ error in
            print(error)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        
        if indexPath.row == 0 {
            tableCell.sectionTitle.text = "Popular Movies"
        }else if indexPath.row == 1 {
            tableCell.sectionTitle.text = "Now Playing"
        }else if indexPath.row == 2 {
            tableCell.sectionTitle.text = "TopRated"
        }else if indexPath.row == 3 {
            tableCell.sectionTitle.text = "Upcoming Movies"
        }
        
        tableCell.collectionView.delegate = self
        tableCell.collectionView.dataSource = self
        tableCell.collectionView.tag = indexPath.row
        tableCell.collectionView.reloadData()
        
        return tableCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return populer.count
        }else if collectionView.tag == 1 {
            return nowPlaying.count
        }else if collectionView.tag == 2 {
            return topRate.count
        }else if collectionView.tag == 3 {
            return upcoming.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        
        if collectionView.tag == 0 {
            cell.loadImage(populer[indexPath.row].poster_path ?? "")
            cell.title.text = populer[indexPath.row].title
            cell.subtitle.text = populer[indexPath.row].release_date
            
        }else if collectionView.tag == 1 {
            cell.loadImage(nowPlaying[indexPath.row].poster_path ?? "")
            cell.title.text = nowPlaying[indexPath.row].title
            cell.subtitle.text = nowPlaying[indexPath.row].release_date
        
        }else if collectionView.tag == 2 {
            cell.loadImage(topRate[indexPath.row].poster_path ?? "")
            cell.title.text = topRate[indexPath.row].title
            cell.subtitle.text = topRate[indexPath.row].release_date
        
        }else if collectionView.tag == 3 {
            cell.loadImage(upcoming[indexPath.row].poster_path ?? "")
            cell.title.text = upcoming[indexPath.row].title
            cell.subtitle.text = upcoming[indexPath.row].release_date
        
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 0 {
            self.openDetails(id: populer[indexPath.row].id!)
        }else if collectionView.tag == 1 {
            self.openDetails(id: nowPlaying[indexPath.row].id!)
        }else if collectionView.tag == 2 {
            self.openDetails(id: topRate[indexPath.row].id!)
        }else if collectionView.tag == 3 {
            self.openDetails(id: upcoming[indexPath.row].id!)
        }
    }
    
    func openDetails(id: Int){
        let nextVc = self.storyboard!.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        nextVc.movieID = String(id)

        self.present(nextVc, animated: true, completion: nil)
    }
    
    

}
