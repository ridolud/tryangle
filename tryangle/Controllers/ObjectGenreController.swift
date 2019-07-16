//
//  ObjectGenreController.swift
//  tryangle
//
//  Created by William Santoso on 16/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

class ObjectGenreController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var listOfFood = ["apple", "applePie", "cupcake", "cupOfMilk", "foodInBowl", "pizza", "sandwich", "sushi"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfFood.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for:  indexPath) as! ObjectGenreCell
        
        cell.objectGenreLabel.text = listOfFood[indexPath.item]
        cell.objectGenreImageView.image = UIImage(named: listOfFood[indexPath.item])
        cell.backgroundObjectGenreView.layer.cornerRadius = 20
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }

}
