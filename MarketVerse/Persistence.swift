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

        // Use an in-memory store if needed, otherwise use the default persistent store
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                // Handle the error properly in production
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        // Enable automatic merging from parent context
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
