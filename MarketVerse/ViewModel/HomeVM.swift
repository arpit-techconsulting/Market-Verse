//
//  HomeVM.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/3/24.
//

import Foundation

struct HomeVM {
    let networkManager = NetworkManager()
    
    func fetchApiData() async {
        do {
            let apiData: Model = try await networkManager.apiCall(apiUrl: "https://dummyjson.com/products?limit=0&skip=0")
            print(apiData)
        } catch {
            print("Error in fetching data from Api: \(error.localizedDescription)")
        }
    }
}
