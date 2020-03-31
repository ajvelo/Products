//
//  Products+CoreDataProperties.swift
//  ProductsApp
//
//  Created by Andreas Velounias on 27/03/2020.
//  Copyright © 2020 Andreas Velounias. All rights reserved.
//
//

import Foundation
import CoreData


extension Products {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Products> {
        return NSFetchRequest<Products>(entityName: "Products")
    }

    @NSManaged public var id: String?
    @NSManaged public var sku: String?
    @NSManaged public var title: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var list_price: String?
    @NSManaged public var is_vatable: Bool
    @NSManaged public var is_for_sale: Bool
    @NSManaged public var age_restricted: Bool
    @NSManaged public var box_limit: Int64
    @NSManaged public var always_on_menu: Bool
    @NSManaged public var volume: Int64
    @NSManaged public var zones: String?
    @NSManaged public var created_at: String?
    @NSManaged public var images: String?
    @NSManaged public var productId: String?

}
