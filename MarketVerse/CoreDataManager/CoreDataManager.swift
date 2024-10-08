//
//  CoreDataManager.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/3/24.
//

import Foundation
import CoreData

struct CoreDataManager {
    private let context = PersistenceController.shared.container.viewContext
    
    func saveToCoreData(products: [Prods]) async {
        products.forEach { prod in
            
            let fetchRequest = NSFetchRequest<Products>(entityName: "Products")
            fetchRequest.predicate = NSPredicate(format: "prod_id == %d", prod.id)
            
            do {
                let existingProducts = try context.fetch(fetchRequest)
                
                //if product exists then update it. Else create a new product
                let prodEntity: Products
                if let existingProduct = existingProducts.first {
                    prodEntity = existingProduct
                    print("Updating existing product with id: \(prod.id)")
                } else {
                    prodEntity = Products(context: context)
                    print("Creating a new product with id: \(prod.id)")
                }
                
                prodEntity.prod_id = prod.id
                prodEntity.title = prod.title
                prodEntity.desc = prod.description
                prodEntity.category = prod.category
                prodEntity.price = prod.price
                prodEntity.discPerc = prod.discountPercentage
                prodEntity.rating = prod.rating
                prodEntity.brand = prod.brand ?? "None"
                prodEntity.weight = prod.weight
                prodEntity.dim_width = prod.dimensions.width
                prodEntity.dim_height = prod.dimensions.height
                prodEntity.dim_depth = prod.dimensions.depth
                prodEntity.warrantyInfo = prod.warrantyInformation
                prodEntity.availableStatus = prod.availabilityStatus
                prodEntity.returnPolicy = prod.returnPolicy
                prodEntity.minOrderQuant = prod.minimumOrderQuantity
                prodEntity.thumbnail = prod.thumbnail
                
            } catch {
                print("Failed to fetch or save product: \(error.localizedDescription)")
            }
            
            // Save changes to Core data
            do {
                try context.save()
                print("Data saved successfully to Core Data")
            } catch {
                print("Failed to save products data in Core Data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchProductsByCategory(category: String) -> [Products] {
        let fetchRequest = NSFetchRequest<Products>(entityName: "Products")
        fetchRequest.predicate = NSPredicate(format: "category == %@", category)
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch Products by category: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchAllCategories() -> [String] {
        let fetchRequest = NSFetchRequest<Products>(entityName: "Products")
        
        do {
            let products = try context.fetch(fetchRequest)
            let categories = Set(products.compactMap { $0.category })
//            print(categories)
            return Array(categories)
        } catch {
            print("Failed to fetch all products to extract categories: \(error.localizedDescription)")
            return []
        }
    }
    
    // Updating Product favorite data and fetching product favorite data from FavProducts entity
    func updateFavoriteStatus(productID: Int, isFavorite: Bool) {
        let fetchRequest = NSFetchRequest<FavProducts>(entityName: "FavProducts")
        fetchRequest.predicate = NSPredicate(format: "prod_id == %d", productID)
        
        do {
            let existingFavProducts = try context.fetch(fetchRequest)
            let favEntity: FavProducts
            
            if let exitsingProduct = existingFavProducts.first {
                favEntity = exitsingProduct
                print("Updating existing product with prod_id: \(productID)")
            } else {
                favEntity = FavProducts(context: context)
                favEntity.prod_id = Int64(productID)
                print("Creating a new product with prod_id: \(productID)")
            }
            
            favEntity.isFavourite = isFavorite
            
            try context.save()
            print("Favorite status updated successfully!!")
        } catch {
            print("Failed to update favorite status: \(error.localizedDescription)")
        }
    }
    
    func isProductFavorite(productID: Int) -> Bool { // Check if product favorite is true or false based on product id
        let fetchRequest = NSFetchRequest<FavProducts>(entityName: "FavProducts")
        fetchRequest.predicate = NSPredicate(format: "prod_id == %d", productID)
        
        do {
            let existingFavProducts = try context.fetch(fetchRequest)
            return existingFavProducts.first?.isFavourite ?? false
        } catch {
            print("Failed to fetch product status for product: \(error.localizedDescription)")
            return false
        }
    }
    
    func fetchAllFavorites() -> [FavProducts] { // Getting all the data in FavProducts Entity
        let fetchRequest = NSFetchRequest<FavProducts>(entityName: "FavProducts")
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch all the favorite products: \(error.localizedDescription)")
            return []
        }
    }
    
    func getProductByID(productID: Int) -> Products? {
        let fetchRequest = NSFetchRequest<Products>(entityName: "Products")
        fetchRequest.predicate = NSPredicate(format: "prod_id == %d", productID)
        
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print("Failed to fetch Product with product id: \(error.localizedDescription)")
            return nil
        }
    }
}
