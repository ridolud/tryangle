//
//  Genre+CoreDataProperties.swift
//  tryangle
//
//  Created by Faridho Luedfi on 16/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//
//

import Foundation
import CoreData


extension Genre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Genre> {
        return NSFetchRequest<Genre>(entityName: "Genre")
    }

    @NSManaged public var image: URL?
    @NSManaged public var name: String?
    @NSManaged public var title: String?
    @NSManaged public var objects: NSSet?

}

// MARK: Generated accessors for objects
extension Genre {

    @objc(addObjectsObject:)
    @NSManaged public func addToObjects(_ value: ObjectGenre)

    @objc(removeObjectsObject:)
    @NSManaged public func removeFromObjects(_ value: ObjectGenre)

    @objc(addObjects:)
    @NSManaged public func addToObjects(_ values: NSSet)

    @objc(removeObjects:)
    @NSManaged public func removeFromObjects(_ values: NSSet)

}
