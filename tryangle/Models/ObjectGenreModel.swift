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
    let tips: String
    
    init(name: String, genre: String, title: String, image: String, object: String, tips: String) {
        self.name = name
        self.title = title
        
        self.image = UIImage(named: image)

        self.genre = genre

        self.object = SCNScene(named: object)
        
        self.tips = tips
    }
    
}

class ObjectGenreModel {
    
    var data: [ObjectGenre] = [
        
        ObjectGenre(name: "pizza", genre: "food", title: "Pizza", image: "pizza", object: "susshiroll.scn", tips: "An object like pizza that have many detail on the top work better with top down angle, so it can show the topping in the surface"),
        ObjectGenre(name: "sushi", genre: "food", title: "Sushi", image: "sushi", object: "susshiroll.scn", tips: "In general, a top down or 75° – 45° angle would probably work best for capturing a table scene, or plates of food"),
        ObjectGenre(name: "apple", genre: "food", title: "Apple", image: "apple", object: "susshiroll.scn", tips: "In general, tall subjects like apple work better straight on to 45° to show the apple shape"),
        ObjectGenre(name: "foodInBowl", genre: "food", title: "Food in Bowl", image: "foodInBowl", object: "susshiroll.scn", tips: "The top down angle is perfect for capturing a bowl of food like curry rice where all the detail is on top"),
        
        ObjectGenre(name: "cupOfMilk", genre: "food", title: "Cup of Milk", image: "cupOfMilk", object: "susshiroll.scn", tips: ""),
        ObjectGenre(name: "sandwich", genre: "food", title: "Sandwich", image: "sandwich", object: "susshiroll.scn", tips: "Sandwich have detail on the side to show the topping and thickness, so straight on to 45° would work the best"),
        ObjectGenre(name: "cupcake", genre: "food", title: "Cup Cake", image: "cupcake", object: "susshiroll.scn", tips: "Cupcake is a subjects with detail on the top, it work better with the top down angle to capture top detail"),
        ObjectGenre(name: "applePie", genre: "food", title: "Apple Pie", image: "applePie", object: "susshiroll.scn", tips: "Pie have many detail on the top so the top down angle can show the detail on the pie surface"),
        
        ObjectGenre(name: "Dance Woman", genre: "potrait", title: "Dancer", image: "Dance Woman", object: "susshiroll.scn", tips: ""),
        ObjectGenre(name: "Baby", genre: "potrait", title: "Baby", image: "Baby", object: "susshiroll.scn", tips: ""),
        ObjectGenre(name: "Pilgrm Man", genre: "potrait", title: "Pilgirm Men", image: "Pilgrm Man", object: "susshiroll.scn", tips: ""),
        ObjectGenre(name: "Pilgrm Woman", genre: "potrait", title: "Pilgirm Women", image: "Pilgrm Woman", object: "susshiroll.scn", tips: ""),
        
        ObjectGenre(name: "Fat Pirate", genre: "potrait", title: "Fat Pirate", image: "Fat Pirate", object: "susshiroll.scn", tips: ""),
        ObjectGenre(name: "Captain Pirate", genre: "potrait", title: "Pirate Captain", image: "Captain Pirate", object: "susshiroll.scn", tips: ""),
        ObjectGenre(name: "Indiana Woman", genre: "potrait", title: "Apache Women", image: "Indiana Woman", object: "susshiroll.scn", tips: ""),
        ObjectGenre(name: "Indiana Man", genre: "potrait", title: "Apache Man", image: "Indiana Man", object: "susshiroll.scn", tips: "")
    ]
    
    func getByGenreName(name: String ) -> [ObjectGenre] {
        return data.filter({ (object: ObjectGenre) -> Bool in
            object.genre == name
        });
    }
    
}

