//
//  ObjectGenreController.swift
//  tryangle
//
//  Created by William Santoso on 16/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

class ObjectGenreController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
//    var listOfFood = ["apple", "applePie", "cupcake", "cupOfMilk", "foodInBowl", "pizza", "sandwich", "sushi"]
    @IBOutlet weak var objectGenreCollection: UICollectionView!
    
    var objectGenreData: [ObjectGenre] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // default titles navigation bar 
        self.navigationController?.navigationBar.prefersLargeTitles = false
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
            guard let indexPath = objectGenreCollection.indexPathsForSelectedItems?.first, let ARCameraVC = segue.destination as? ARCameraController else { return }
            let currentGenreObject = objectGenreData[ indexPath.row ]
            ARCameraVC.title = currentGenreObject.title
        }
    }

}
