//
//  HomeVM.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/3/24.
//

import Foundation

struct HomeVM {
    private let networkManager = NetworkManager()
    private let coreDataManager = CoreDataManager() // there are two dependencies in one structure, work on removing the dependencies (not a good practice)
    
    func fetchApiData() async {
        do {
            let apiData: Model = try await networkManager.apiCall(apiUrl: "https://dummyjson.com/products?limit=0&skip=0")
//            print(apiData)
            await coreDataManager.saveToCoreData(products: apiData.products)
        } catch {
            print("Error in fetching data from Api: \(error.localizedDescription)")
        }
    }
}
