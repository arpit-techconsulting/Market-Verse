//
//  Home.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/3/24.
//

import SwiftUI

struct Home: View {
    
    var body: some View {
        Text("Hello, World!")
        
            .onAppear {
                Task {
                    await fetchApiData()
                }
            }
    }
    
    func fetchApiData() async {
        let networkManager = NetworkManager()
        
        do {
            let fetchedData = try await networkManager.apiCall(apiUrl: "https://dummyjson.com/products?limit=0&skip=0")
            print(fetchedData)
        } catch {
            print("Error in fetching data from api: \(error)")
        }
    }
}

#Preview {
    Home()
}
