//
//  AttributesModel.swift
//  ProductsApp
//
//  Created by Andreas Velounias on 27/03/2020.
//  Copyright © 2020 Andreas Velounias. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON



class AttributesModel: NSObject {
    
    var ID : String = ""
    var titles : String = ""
    var unit : String = ""
    var value : String = ""
    var productId : String = ""


    override init() {
        super.init()
    }
    
    init(withDictionary dictionary: [String: JSON]) {
        super.init()
        
        if let ID = dictionary["id"]?.string {
            self.ID = ID
        }
        if let value = dictionary["title"]?.stringValue {
            self.titles = value
        }
        if let value = dictionary["unit"]?.stringValue {
            self.unit = value
        }
        if let value = dictionary["value"]?.stringValue {
            self.value = value
        }
    }
    
}
