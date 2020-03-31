//
//  PersistanceServices.swift
//  Dispatcher
//
//  Created by Andreas Velounias on 29/03/2020.
//  Copyright © 2019 Andreas Velounias. All rights reserved.
//

import Foundation
import CoreData
class PersistanceServices{
    
    static let shared = PersistanceServices()
    
    private init() {
        
    }
    
    static var context : NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "ProductsApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    static func saveContext ()  {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
     
    }
    
    static func resetPersistentStore() {

        if let persistentStore = PersistanceServices.persistentContainer.persistentStoreCoordinator.persistentStores.last {
            let storeURL = persistentContainer.persistentStoreCoordinator.url(for: persistentStore)

            do {
                try persistentContainer.persistentStoreCoordinator.destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: nil)
            } catch {
                print("failed to destroy persistent store:", error.localizedDescription)
            }

            do {
                try persistentContainer.persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            } catch {
                print("failed to re-add persistent store:", error.localizedDescription)
            }
        }

    }
}
