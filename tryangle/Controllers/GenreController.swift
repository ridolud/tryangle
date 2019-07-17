//
//  GenreController.swift
//  tryangle
//
//  Created by Faridho Luedfi on 10/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

class GenreController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    var genreData: GenreModel = GenreModel()
    
    let userDef = UserDefaults.standard
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return genreData.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = genreCollectionView.dequeueReusableCell(withReuseIdentifier: "genreCell", for: indexPath) as! GenreCell

        let genre = self.genreData.data[indexPath.row]
            cell.imageView.image = genre.image
            cell.textView.text = genre.title
        
        return cell
    }
    
    fileprivate func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: (view.bounds.width - layout.sectionInset.left - layout.sectionInset.right), height: 275)
        layout.minimumLineSpacing = 20
        
        genreCollectionView.collectionViewLayout = layout
        genreCollectionView.reloadData()
    }
    
    fileprivate func setDelegate() {
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        setUpCollectionView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "genreObjectSegue" {
            guard let indexPath = genreCollectionView.indexPathsForSelectedItems?.first, let objectGenreVC = segue.destination as? ObjectGenreController else { return }
            let currentGenre = self.genreData.data[ indexPath.row ]
            objectGenreVC.title = currentGenre.title
            let objectGenre = ObjectGenreModel()
            objectGenreVC.objectGenreData = objectGenre.getByGenreName(name: currentGenre.name)
            print(objectGenreVC.objectGenreData)
        }
    }
}
