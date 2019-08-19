//
//  FavouritesViewController.swift
//  MoviesApp
//
//  Created by Ahmed on 8/19/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import UIKit
import CoreData

class FavouritesViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataController: DataController!
    
    var fetchedResultsController : NSFetchedResultsController<MovieItem>!

    var favResults = [MovieItem]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        dataController = appDelegate.dataController
        
        self.navigationItem.title = "Favourites"
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(self.closeBackButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupFetchedResultsController()
    }
    
    @objc func closeBackButtonPressed(){
        self.dismiss(animated: true, completion: nil)
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
        
        favResults = fetchedResultsController.fetchedObjects!
        
        collectionView.reloadData()
    }

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        
        cell.loadImage(favResults[indexPath.row].poster_path ?? "")
        cell.title.text = favResults[indexPath.row].title
        cell.subtitle.text = favResults[indexPath.row].release_date
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.openDetails(id: Int(favResults[indexPath.row].id))
    }
    
    
    func openDetails(id: Int){
        let nextVc = self.storyboard!.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        nextVc.movieID = String(id)
        
        self.present(nextVc, animated: true, completion: nil)
    }
    
}
