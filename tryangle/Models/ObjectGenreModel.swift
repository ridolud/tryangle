//
//  ObjectGenreModel.swift
//  tryangle
//
//  Created by Faridho Luedfi on 16/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit
import SceneKit

let genreModel = GenreModel()

struct ObjectGenre {
    
    let name: String
    let genre: String
    let title: String
    let image: UIImage?
    let object: SCNScene?
    
    init(name: String, genre: String, title: String, image: String, object: String) {
        self.name = name
        self.title = title
        
            self.image = UIImage(named: image)

            self.genre = genre
    
            self.object = SCNScene(named: object)
    }
    
}

class ObjectGenreModel {
    
    var data: [ObjectGenre] = [
        
        ObjectGenre(name: "apple", genre: "food", title: "Apple", image: "apple", object: "susshiroll.scn"),
        ObjectGenre(name: "applePie", genre: "food", title: "Apple Pie", image: "applePie", object: "susshiroll.scn"),
        ObjectGenre(name: "cupcake", genre: "food", title: "Cup Cake", image: "cupcake", object: "susshiroll.scn"),
        
        ObjectGenre(name: "ely", genre: "potrait", title: "Apple", image: "apple", object: "susshiroll.scn"),
        ObjectGenre(name: "boz", genre: "potrait", title: "Apple Pie", image: "applePie", object: "susshiroll.scn"),
        ObjectGenre(name: "nessy", genre: "potrait", title: "Cup Cake", image: "cupcake", object: "susshiroll.scn")
    ]
    
    func getByGenreName(name: String ) -> [ObjectGenre] {
        return data.filter({ (object: ObjectGenre) -> Bool in
            object.genre == name
        });
    }
    
}

