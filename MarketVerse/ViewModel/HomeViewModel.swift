//
//  HomeVM.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/3/24.
//

import Foundation

protocol HomeViewModelActions {
    func fetchApiData() async
    func fetchProductsByCategory(category: String) -> [Products]
    func fetchAllCategories() async
}

class HomeViewModel: ObservableObject, HomeViewModelActions {
    private let networkManager = NetworkManager()
    private let coreDataManager = CoreDataManager() // there are two dependencies in one structure, work on removing the dependencies (not a good practice)
    @Published var categories: [String] = []

    func fetchApiData() async {
        
        // Do error handling of APIs
        do {
            let apiData: Model = try await networkManager.apiCall(apiUrl: "https://dummyjson.com/products?limit=0&skip=0")
            //            print(apiData)
            await coreDataManager.saveToCoreData(products: apiData.products)
        } catch {
            print("Error in fetching data from Api: \(error.localizedDescription)")
        }
    }
    
    func fetchProductsByCategory(category: String) -> [Products] {
        coreDataManager.fetchProductsByCategory(category: category)
    }
    
    func fetchAllCategories() async {
        DispatchQueue.main.async {
            self.categories = self.coreDataManager.fetchAllCategories()
            print("Fetched categories after API call: \(self.categories)") // Do it in view model
        }
    }
}
