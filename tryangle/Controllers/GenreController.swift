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
        
        layout.sectionInset = UIEdgeInsets(top: 32, left: 32, bottom: 32, right: 32)
        layout.itemSize = CGSize(width: (view.bounds.width - layout.sectionInset.left - layout.sectionInset.right), height: 304)
        layout.minimumLineSpacing = 32
        
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
        
//        print(self.navigationController?.navigationBar.barTintColor)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationConfig()
    }
    
    
    // Config navigation.
    func navigationConfig() {
        self.navigationController?.navigationBar.barTintColor = .init(red: 0.250952, green: 0.251, blue: 0.250946, alpha: 1)
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
    
    @IBAction func unwindToVC1
        (unwindSegue:UIStoryboardSegue) { }
}
