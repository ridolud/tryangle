//
//  GenreModel.swift
//  tryangle
//
//  Created by Faridho Luedfi on 16/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

struct Genre {
    
    let name: String
    let title: String
    let image: UIImage
    
}

class GenreModel {
    
    var data: [ Genre ] = []
    
    var name: String!
    var title: String!
    var image: UIImage!
    
    init() {
        self.data = self.setDefault()
    }
    
    func add(_ data: Genre) {
        self.data.append(data)
    }
    
    private func setDefault() -> [Genre] {
    
        var defaultData: [Genre] = []
        defaultData.append(Genre(name: "food", title: "Food Photography", image: UIImage(named: "genre-1")!))
        defaultData.append(Genre(name: "potrait", title: "Potrait Photography", image: UIImage(named: "genre-1")!))
        
        return defaultData
    
    }
    
}

