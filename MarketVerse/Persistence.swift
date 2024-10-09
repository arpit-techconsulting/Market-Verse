//
//  Persistence.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 9/30/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MarketVerse")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        // Enable migration
        container.persistentStoreDescriptions.first?.shouldMigrateStoreAutomatically = true
        container.persistentStoreDescriptions.first?.shouldInferMappingModelAutomatically = true

        // Remove existing persistent store if necessary
        let storeURL = container.persistentStoreDescriptions.first?.url
        let fileManager = FileManager.default
        if let storeURL = storeURL, fileManager.fileExists(atPath: storeURL.path) {
            do {
                try fileManager.removeItem(at: storeURL)
                print("Persistent store removed successfully")
            } catch {
                print("Failed to remove persistent store: \(error)")
            }
        }

        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error loading persistent store: \(error), \(error.userInfo)")
            } else {
                print("Persistent store loaded successfully")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

