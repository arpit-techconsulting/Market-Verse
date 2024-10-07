//
//  FavProductsViewModel.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/7/24.
//

import SwiftUI

class FavProductsViewModel: ObservableObject {
    private let coreDataManager = CoreDataManager()
    
    @Published var favoriteProducts: [Int: Bool] = [:]
    
    init() {
        loadFavProducts()
    }
    
    func loadFavProducts() { // func to load all the favorite products
        let favProducts = coreDataManager.fetchAllFavorites()
        favoriteProducts = favProducts.reduce(into: [:], { result, favProduct in
            result[Int(favProduct.prod_id)] = favProduct.isFavourite
        })
    }
    
    func toggleFavoriteStatus(productID: Int) {
        let currentStatus = favoriteProducts[productID] ?? false
        let newStatus = !currentStatus
        favoriteProducts[productID] = newStatus
        coreDataManager.updateFavoriteStatus(productID: productID, isFavorite: newStatus)
        
        if !newStatus {
            favoriteProducts.removeValue(forKey: productID) // Instantly removes item from favorites section
        }
    }
    
    func isFavorite(productID: Int) -> Bool { // Func to say if a product is true or false
        return coreDataManager.isProductFavorite(productID: productID)
    }
    
    func getProductByID(productID: Int) -> Products? { // func to get a single product from Products Entity
        return coreDataManager.getProductByID(productID: productID)
    }
}
