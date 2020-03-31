//
//  FetchPersistantData.swift
//  Dispatcher
//
//  Created by Andreas Velounias on 29/03/2020.
//  Copyright © 2019 Andreas Velounias. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class FetchPersistentData{
    class func isAlreadyExist(id: String ,entityName : String, fieldName : String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "\(fieldName) == %@", id)
        let managedContext = PersistanceServices.persistentContainer.viewContext

        var results: [NSManagedObject] = []
        
        do {
            results = try managedContext.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        
        return results.count > 0
    }
    
    class func getProducts() -> [ProductsModel] {
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        
        //We need to create a context from this container
        let managedContext = PersistanceServices.persistentContainer.viewContext
        var arrProducts = [ProductsModel]()
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Products")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let product = ProductsModel()
                product.ID = data.value(forKey: "id") as? String ?? ""
                product.sku = data.value(forKey: "sku") as? String ?? ""
                product.titles = data.value(forKey: "title") as? String ?? ""
                product.descriptions = data.value(forKey: "descriptions") as? String ?? ""
                product.listPrices = data.value(forKey: "list_price") as? String ?? ""
                product.isVatable = data.value(forKey: "is_vatable") as? Bool ?? false
                product.isForSale = data.value(forKey: "is_for_sale") as? Bool ?? false
                product.ageRestricted = data.value(forKey: "age_restricted") as? Bool ?? false
                product.boxLimit = data.value(forKey: "box_limit") as? Int ?? 0
                product.alwaysOnMenu = data.value(forKey: "always_on_menu") as? Bool ?? false
                
                product.image.append(data.value(forKey: "images") as? String ?? "")

                product.volume = data.value(forKey: "volume") as? Int ?? 0
               product.zone = data.value(forKey: "zones") as? String ?? ""
               product.createdAt = data.value(forKey: "created_at") as? String ?? ""
                product.arrAttributes = FetchPersistentData.getAttributes(productId: product.ID)
                product.tags = FetchPersistentData.getTags(productId: product.ID)
                arrProducts.append(product)
            }
            return arrProducts

            
        } catch {
            
            print("Failed")
        }
        return arrProducts
    }
    
    
    class func getFilteredProducts(search : String) -> [ProductsModel] {
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        
        //We need to create a context from this container
        let managedContext = PersistanceServices.persistentContainer.viewContext
        var arrProducts = [ProductsModel]()
        //Prepare the request of type NSFetchRequest  for the entity

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Products")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let product = ProductsModel()
                product.ID = data.value(forKey: "id") as? String ?? ""
                product.sku = data.value(forKey: "sku") as? String ?? ""
                product.titles = data.value(forKey: "title") as? String ?? ""
                product.descriptions = data.value(forKey: "descriptions") as? String ?? ""
                product.listPrices = data.value(forKey: "list_price") as? String ?? ""
                product.isVatable = data.value(forKey: "is_vatable") as? Bool ?? false
                product.isForSale = data.value(forKey: "is_for_sale") as? Bool ?? false
                product.ageRestricted = data.value(forKey: "age_restricted") as? Bool ?? false
                product.boxLimit = data.value(forKey: "box_limit") as? Int ?? 0
                product.alwaysOnMenu = data.value(forKey: "always_on_menu") as? Bool ?? false
                
            product.image.append(data.value(forKey: "images") as? String ?? "") 
                product.volume = data.value(forKey: "volume") as? Int ?? 0
               product.zone = data.value(forKey: "zones") as? String ?? ""
               product.createdAt = data.value(forKey: "created_at") as? String ?? ""
                product.arrAttributes = FetchPersistentData.getAttributes(productId: product.ID)
                product.tags = FetchPersistentData.getTags(productId: product.ID)
                
                arrProducts.append(product)
                
            }
            let filtered = arrProducts.filter { $0.titles.lowercased().contains(search.lowercased())
                
            }
            
            return filtered

            
        } catch {
            
            print("Failed")
        }
        return arrProducts
    }
    
    
    class func getAttributes(productId : String) -> [AttributesModel] {
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        
        //We need to create a context from this container
        let managedContext = PersistanceServices.persistentContainer.viewContext
        var arrAttributes = [AttributesModel]()
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Attributes")
        
        fetchRequest.predicate = NSPredicate(format: "productId == %@", productId)
               
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let attributes = AttributesModel()
                attributes.ID = data.value(forKey: "id") as? String ?? ""
                attributes.productId = data.value(forKey: "productId") as? String ?? ""
                attributes.titles = data.value(forKey: "title") as? String ?? ""
                attributes.unit = data.value(forKey: "unit") as? String ?? ""
                attributes.value = data.value(forKey: "value") as? String ?? ""

                
                
                arrAttributes.append(attributes)
            }
            return arrAttributes

            
        } catch {
            
            print("Failed")
        }
        return arrAttributes
    }
    
    
    class func getTags(productId : String) -> [String] {
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        
        //We need to create a context from this container
        let managedContext = PersistanceServices.persistentContainer.viewContext
        var arrTags = [String]()
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tags")
        
        //        fetchRequest.fetchLimit = 1
                fetchRequest.predicate = NSPredicate(format: "productId == %@", productId)
               // fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
        //
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                
                let tag = data.value(forKey: "title") as? String ?? ""

                
                
                arrTags.append(tag)
            }
            return arrTags

            
        } catch {
            
            print("Failed")
        }
        return arrTags
    }
    
    
}
