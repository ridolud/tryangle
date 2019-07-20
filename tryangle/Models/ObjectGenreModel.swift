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
        
        ObjectGenre(name: "pizza", genre: "food", title: "Pizza", image: "pizza", object: "pizza.dae", tips: "An object like pizza that have many detail on the top work better with top down angle, so it can show the topping in the surface"),
        ObjectGenre(name: "sushi", genre: "food", title: "Sushi", image: "sushi", object: "Sushi.scn", tips: "In general, a top down or 75° – 45° angle would probably work best for capturing a table scene, or plates of food"),
        ObjectGenre(name: "apple", genre: "food", title: "Apple", image: "apple", object: "apple.scn", tips: "In general, tall subjects like apple work better straight on to 45° to show the apple shape"),
        ObjectGenre(name: "Curry Rice", genre: "food", title: "Curry Rice", image: "Curry Rice", object: "Curry Rice.scn", tips: "The top down angle is perfect for capturing a bowl of food like curry rice where all the detail is on top"),
        
        ObjectGenre(name: "weddingCake", genre: "food", title: "Wedding Cake", image: "weddingCake", object: "Wedding Cake.dae", tips: "In general, wedding cakes with layers typically look best shot straight-on to emphasize the layers and height of the cake"),
        ObjectGenre(name: "sandwich", genre: "food", title: "Sandwich", image: "sandwich", object: "Sandwich.scn", tips: "Sandwich have detail on the side to show the topping and thickness, so straight on to 45° would work the best"),
        ObjectGenre(name: "cupcake", genre: "food", title: "Cup Cake", image: "cupcake", object: "cupcake.scn", tips: "Cupcake is a subjects with detail on the top, it work better with the top down angle to capture top detail"),
        ObjectGenre(name: "applePie", genre: "food", title: "Apple Pie", image: "applePie", object: "Apple Pie.scn", tips: "Pie have many detail on the top so the top down angle can show the detail on the pie surface"),
        
        
        ObjectGenre(name: "Dance Woman", genre: "potrait", title: "Dancer", image: "Dance Woman", object: "Dancer.scn", tips: "Eye level shot is good for a performer because it will show the body proportional"),
        ObjectGenre(name: "Baby", genre: "potrait", title: "Baby", image: "Baby", object: "baby.obj", tips: "This is a common rule in baby photography, the best angle is always when you go and level yourself with the baby"),
        ObjectGenre(name: "Pilgrm Man", genre: "potrait", title: "Pilgirm Man", image: "Pilgrm Man", object: "11553_Pilgrim_male_v2_l2.obj", tips: "Eye level shot will make the pilgrim man looks proportional"),
        ObjectGenre(name: "Pilgrm Woman", genre: "potrait", title: "Pilgirm Woman", image: "Pilgrm Woman", object: "Pilgrim Woman.scn", tips: "Eye level shot is fit with the pilgrim woman to make her look proportional"),
        
        ObjectGenre(name: "Fat Pirate", genre: "potrait", title: "Fat Pirate", image: "Fat Pirate", object: "Fat Pirate.scn", tips: "Eye level shot will make the fat pirate looks proportional, but if you want to make him creeper, use the low angle shot"),
        ObjectGenre(name: "Captain Pirate", genre: "potrait", title: "Pirate Captain", image: "Captain Pirate", object: "Pirate Captain.scn", tips: "You can make the captain more manly dan heroic by capturing it with low angle shot"),
        ObjectGenre(name: "Indiana Woman", genre: "potrait", title: "Apache Woman", image: "Indiana Woman", object: "Indian Woman.scn", tips: "Eye level shot is best fit for the apache man to make him looks proportional"),
        ObjectGenre(name: "Indiana Man", genre: "potrait", title: "Apache Man", image: "Indiana Man", object: "Indiana Man.scn", tips: "Eye level shot is best fit for the apache woman to make her looks proportional")
    ]
    
    func getByGenreName(name: String ) -> [ObjectGenre] {
        return data.filter({ (object: ObjectGenre) -> Bool in
            object.genre == name
        });
    }
    
}

