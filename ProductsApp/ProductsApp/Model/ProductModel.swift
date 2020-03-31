//
//  ProductModel.swift
//  ProductsApp
//
//  Created by Andreas Velounias on 27/03/2020.
//  Copyright © 2020 Andreas Velounias. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ProductsModel: NSObject {
    var sku: String = ""
    var titles: String = ""
    var ID : String = ""
    var descriptions: String = ""
    var listPrices: String = ""
    var isVatable: Bool = false
    var isForSale = false
    var ageRestricted = false
    var boxLimit : Int = 0
    var alwaysOnMenu = false
    var volume = 0
    var zone = ""
    var createdAt = ""
    var tags = Array<String>()
    var image =  Array<String>()
    var arrAttributes = Array<AttributesModel>()
    

    override init() {
        super.init()
    }
    
    init(withDictionary dictionary: [String: JSON]) {
        super.init()
        
        if let ID = dictionary["id"]?.string {
            self.ID = ID
        }
        
        if let value = dictionary["sku"]?.string {
            self.sku = value
        }
        if let value = dictionary["title"]?.stringValue {
            self.titles = value
        }
        if let value = dictionary["description"]?.stringValue {
            self.descriptions = value
        }
       
        if let value = dictionary["list_price"]?.stringValue {
            self.listPrices = value
            
        }
        
        if let value = dictionary["is_vatable"]?.boolValue {
            self.isVatable = value
        }
        if let value = dictionary["is_for_sale"]?.boolValue {
            self.isForSale = value
        }
        if let value = dictionary["age_restricted"]?.boolValue {
            self.ageRestricted = value
        }
        if let value = dictionary["box_limit"]?.intValue {
            self.boxLimit = value
        }
        if let value = dictionary["always_on_menu"]?.boolValue {
            self.alwaysOnMenu = value
        }
        
        if let value = dictionary["volume"]?.intValue {
            self.volume = value
        }
        
        if let value = dictionary["zone"]?.stringValue {
            self.zone = value
        }
        if let value = dictionary["tags"]?.arrayValue {
            for obj in value{
                let object = obj.stringValue
                self.tags.append(object)
            }
        }
        if let value = dictionary["images"]?.dictionaryValue {
            let width = UIScreen.main.bounds.width
            if let object = value["\(width)"]?.dictionaryValue {
                if let value  = object["src"]?.stringValue{
                    self.image.append(value)
                }
                
            }
        }
        
        if let arrAttributes = dictionary["attributes"]?.arrayValue {
            for product in arrAttributes{
                let object = AttributesModel.init(withDictionary: product.dictionaryValue)
                self.arrAttributes.append(object)
            }
        }
    }
    
}
