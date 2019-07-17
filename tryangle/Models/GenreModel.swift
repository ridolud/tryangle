//
//  GenreModel.swift
//  tryangle
//
//  Created by Faridho Luedfi on 16/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit
import CoreData

class GenreModel {
    
    // TODO: masih kosong jika pertama kali buka app.
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var name: String!

    var title: String!
    
    var imageUri: String!
    
    var data: [ Genre ] = []
    
    init() {
        self.setDefaultData()
    }
    
    init( name: String, title: String, imageName: String ) {
        self.name = name
        self.title = title
        self.imageUri = imageName
    }
    
    func save() {
        let reqData = Genre(context: self.context)
        
        reqData.name = self.name
        reqData.title = self.title
        reqData.image = self.imageUri
        data.append(reqData)
        
        do {
            try self.context.save()
            self.fetch()
        }
        catch { print("Error ... ", error ) }
    }
    
    func save(_ item: Genre) {
        let reqData = Genre(context: self.context)
        
        reqData.name = item.name
        reqData.title = item.title
        reqData.image = item.image
        data.append(reqData)
        
        do { try self.context.save() }
        catch { print("Error ... ", error ) }
    }
    
    func fetch() {
        let request: NSFetchRequest = Genre.fetchRequest()
        
        do { data = try self.context.fetch(request) }
        catch { print("Error .. ", error) }
    }

    // MARK: Seeding ...
    private var genreName: [String] = [ "food", "potrait" ]
    
    private var genreTitle: [String] = [ "Food Photography", "Potrait Photography" ]
    
    private var genreImage: [String] = [ "genre-1", "genre-1" ]
    
    private var listOfObjectImageName = [
        ["apple", "applePie", "cupcake", "cupOfMilk", "foodInBowl", "pizza", "sandwich", "sushi"],
        ["Male", "Female"]
    ]
    
    func setDefaultData() {
        self.fetch()
        
        let isNotFirstInitApp = UserDefaults.standard.bool(forKey: "isNotFistInitApp")
        
        if !isNotFirstInitApp {
            
            for n in 0 ... ( self.genreName.count - 1 ) {
                let genre = GenreModel(
                    name: genreName[n],
                    title: genreTitle[n],
                    imageName: genreImage[n]
                )
                genre.save()
            }
            
            UserDefaults.standard.set(true, forKey: "isNotFistInitApp")
        }
        
    }


}

