//
//  Attributes+CoreDataProperties.swift
//  ProductsApp
//
//  Created by Andreas Velounias on 27/03/2020.
//  Copyright © 2020 Andreas Velounias. All rights reserved.
//
//

import Foundation
import CoreData


extension Attributes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attributes> {
        return NSFetchRequest<Attributes>(entityName: "Attributes")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var unit: String?
    @NSManaged public var value: String?
    @NSManaged public var productId: String?

}
