//
//  GenreModel.swift
//  tryangle
//
//  Created by Faridho Luedfi on 16/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

let objectGenreModel = ObjectGenreModel()

struct Genre {
    
    let name: String
    let title: String
    let image: UIImage
    
}

class GenreModel {
    
    var data: [ Genre ] = [
        Genre(name: "food", title: "Food Photography", image: UIImage(named: "Food Genre")!),
        Genre(name: "potrait", title: "Potrait Photography", image: UIImage(named: "Portrait Genre")!),
    ]
    
    func getByName(name: String) -> Genre? {
        return data.first(where: { $0.name == name })
    }
    
}
