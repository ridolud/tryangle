//
//  ObjectGenre+CoreDataProperties.swift
//  tryangle
//
//  Created by Faridho Luedfi on 16/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//
//

import Foundation
import CoreData


extension ObjectGenre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ObjectGenre> {
        return NSFetchRequest<ObjectGenre>(entityName: "ObjectGenre")
    }

    @NSManaged public var image: URL?
    @NSManaged public var isDone: Bool
    @NSManaged public var name: String?
    @NSManaged public var title: String?
    @NSManaged public var genre: Genre?

}
