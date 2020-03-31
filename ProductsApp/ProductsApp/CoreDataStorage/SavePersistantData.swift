//
//  SavePersistantData.swift
//  Dispatcher
//
//  Created by Andreas Velounias on 29/03/2020.
//  Copyright © 2019 Andreas Velounias. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SDWebImage
import SwiftyJSON
public class SavePersistantData{
    
    class func saveProduct(product : ProductsModel){
        if FetchPersistentData.isAlreadyExist(id: product.ID, entityName: "Products", fieldName: "id") {
            SavePersistantData.updateProduct(product: product)
        }
        else{
            let managedContext = PersistanceServices.persistentContainer.viewContext
            let userEntity = NSEntityDescription.entity(forEntityName: "Products", in: PersistanceServices.persistentContainer.viewContext
                )!
            let productObject = NSManagedObject(entity: userEntity, insertInto: PersistanceServices.persistentContainer.viewContext)
            productObject.setValue(product.ID, forKey: "id")
            productObject.setValue(product.sku, forKey: "sku")
            productObject.setValue(product.titles, forKey: "title")
            productObject.setValue(product.descriptions, forKey: "descriptions")
            productObject.setValue(product.listPrices, forKey: "list_price")
            productObject.setValue(product.isVatable, forKey: "is_vatable")
            productObject.setValue(product.isForSale, forKey: "is_for_sale")
            productObject.setValue(product.ageRestricted, forKey: "age_restricted")
            productObject.setValue(product.boxLimit, forKey: "box_limit")
            productObject.setValue(product.alwaysOnMenu, forKey: "always_on_menu")
            productObject.setValue(product.volume, forKey: "volume")
            productObject.setValue(product.zone, forKey: "zones")
            if product.image.count > 0{
                productObject.setValue(product.image[0], forKey: "images")

            }
            productObject.setValue(product.createdAt, forKey: "created_at")
            for object in product.arrAttributes{
                object.productId = product.ID
                SavePersistantData.saveAttributes(attributes: object)
            }
            if product.tags.count > 0{
                SavePersistantData.saveTags(tag:product.tags, productId: product.ID)

            }
            do{
                
                try managedContext.save()
                
            }
            catch
            {
                print(error)
            }
        }
    }
    
    class func saveAttributes(attributes : AttributesModel){
        if FetchPersistentData.isAlreadyExist(id: attributes.ID, entityName: "Attributes", fieldName: "id") {
            SavePersistantData.updateAttributes(attributes: attributes)
        }
        else{
            let managedContext = PersistanceServices.persistentContainer.viewContext
            let userEntity = NSEntityDescription.entity(forEntityName: "Attributes", in: PersistanceServices.persistentContainer.viewContext
                )!
            let attribute = NSManagedObject(entity: userEntity, insertInto: PersistanceServices.persistentContainer.viewContext)
            attribute.setValue(attributes.ID, forKey: "id")
            attribute.setValue(attributes.value, forKey: "value")
            attribute.setValue(attributes.titles, forKey: "title")
            attribute.setValue(attributes.productId, forKey: "productId")
            attribute.setValue(attributes.unit, forKey: "unit")
            do{
                try managedContext.save()
                
            }
            catch
            {
                print(error)
            }
        }
    }
    
    
    class func updateProduct(product : ProductsModel){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        
        
        //We need to create a context from this container
        let managedContext = PersistanceServices.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Products")
        fetchRequest.predicate = NSPredicate(format: "id == %@", product.ID)
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            let productObject = test[0] as! NSManagedObject
            productObject.setValue(product.ID, forKey: "id")
            productObject.setValue(product.sku, forKey: "sku")
            productObject.setValue(product.titles, forKey: "title")
            productObject.setValue(product.descriptions, forKey: "descriptions")
            productObject.setValue(product.listPrices, forKey: "list_price")
            productObject.setValue(product.isVatable, forKey: "is_vatable")
            productObject.setValue(product.isForSale, forKey: "is_for_sale")
            productObject.setValue(product.ageRestricted, forKey: "age_restricted")
            productObject.setValue(product.boxLimit, forKey: "box_limit")
            productObject.setValue(product.alwaysOnMenu, forKey: "always_on_menu")
            productObject.setValue(product.volume, forKey: "volume")
            productObject.setValue(product.zone, forKey: "zones")
            productObject.setValue(product.createdAt, forKey: "created_at")
            if product.image.count > 0{
                productObject.setValue(product.image[0], forKey: "images")

            }
            for object in product.arrAttributes{
                object.productId = product.ID
                SavePersistantData.saveAttributes(attributes: object)
            }
            if product.tags.count > 0{
                SavePersistantData.saveTags(tag:product.tags, productId: product.ID)

            }
            do{
                try managedContext.save()
                
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
        
    }
    
    
    class func updateAttributes(attributes : AttributesModel){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        
        
        //We need to create a context from this container
        let managedContext = PersistanceServices.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Attributes")
        fetchRequest.predicate = NSPredicate(format: "id == %@", attributes.ID)
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            let attribute = test[0] as! NSManagedObject
            attribute.setValue(attributes.ID, forKey: "id")
            attribute.setValue(attributes.value, forKey: "value")
            attribute.setValue(attributes.titles, forKey: "title")
            attribute.setValue(attributes.productId, forKey: "productId")
            attribute.setValue(attributes.unit, forKey: "unit")
            do{
                try managedContext.save()
                
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
        
    }
    
    class func saveTags(tag : Array<String>, productId : String){
        if FetchPersistentData.isAlreadyExist(id: productId, entityName: "Tags", fieldName: "productId") {
        }
        else{
            let managedContext = PersistanceServices.persistentContainer.viewContext
            let userEntity = NSEntityDescription.entity(forEntityName: "Tags", in: PersistanceServices.persistentContainer.viewContext
                )!
            for item in tag {
                let tag = NSManagedObject(entity: userEntity, insertInto: PersistanceServices.persistentContainer.viewContext)
                tag.setValue(item, forKey: "title")
                tag.setValue(productId, forKey: "productId")
                do{
                    try managedContext.save()
                    
                }
                catch
                {
                    print(error)
                }
            }
            
        }
    }
}
