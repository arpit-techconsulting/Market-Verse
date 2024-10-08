//
//  HomeVM.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/3/24.
//

import Foundation

struct HomeViewModel {
    private let networkManager = NetworkManager()
    private let coreDataManager = CoreDataManager() // there are two dependencies in one structure, work on removing the dependencies (not a good practice)
    
    func fetchApiData() async { // put this in main actor
        // Check if data is already saved in Core Data
//        let isDataSaved = UserDefaults.standard.bool(forKey: "isDataSaved")
//        guard !isDataSaved else {
//            print("Data is already saved in Core Data. Skipping Api Call")
//            completion()
//            return
//        }
        
        // Do error handling of APIs
        
        do {
            let apiData: Model = try await networkManager.apiCall(apiUrl: "https://dummyjson.com/products?limit=0&skip=0")
//            print(apiData)
            await coreDataManager.saveToCoreData(products: apiData.products)
            
            // Set flag for storing data in Core Data
//            UserDefaults.standard.set(true, forKey: "isDataSaved")
        } catch {
            print("Error in fetching data from Api: \(error.localizedDescription)")
        }
    }
    
    func fetchProductsByCategory(category: String) -> [Products] {
        coreDataManager.fetchProductsByCategory(category: category)
    }
    
    func fetchAllCategories() -> [String] { 
        coreDataManager.fetchAllCategories()
    }
}
