//
//  ObjectGenreController.swift
//  tryangle
//
//  Created by William Santoso on 16/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

class ObjectGenreController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var objectGenreCollection: UICollectionView!
    
    var objectGenreData: [ObjectGenre] = []

    var genreData: GenreModel = GenreModel()
    
    var currentGenreStatus: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationConfig()
    }
    
    
    // Config navigation.
    func navigationConfig() {
        self.navigationController?.navigationBar.barTintColor = .init(red: 0.250952, green: 0.251, blue: 0.250946, alpha: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objectGenreData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for:  indexPath) as! ObjectGenreCell
        
        cell.objectGenreLabel.text = objectGenreData[indexPath.item].title
        cell.objectGenreImageView.image = objectGenreData[indexPath.item].image
        cell.backgroundObjectGenreView.layer.cornerRadius = 20
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "genreObjectARSegue" {
            guard let indexPath = objectGenreCollection.indexPathsForSelectedItems?.first, let ARCameraVC = segue.destination as? ARAngleControlle else { return }
            let currentGenreObject = objectGenreData[indexPath.row]
            ARCameraVC.title = currentGenreObject.title
            ARCameraVC.currentGenreObject = currentGenreObject
        }
    }

    
}
