//
//  HomeVM.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/3/24.
//

import Foundation

struct ErrorMessage: Identifiable {
    let id = UUID()
    let message: String
}

protocol HomeViewModelActions {
    func fetchApiData() async
    func fetchProductsByCategory(category: String) -> [Products]
    func fetchAllCategories() async
}

class HomeViewModel: ObservableObject, HomeViewModelActions {
    private let networkManager = NetworkManager()
    private let coreDataManager = CoreDataManager() // there are two dependencies in one structure, work on removing the dependencies (not a good practice)
    @Published var errorMessage: ErrorMessage?
    @Published var categories: [String] = []

    func fetchApiData() async {
        
        // Do error handling of APIs
        if !coreDataManager.isDataSavedToCoreData() {
            do {
                let apiData: Model = try await networkManager.apiCall(apiUrl: "https://dummyjson.com/products?limit=0&skip=0", responseModel: Model.self)
                //            print(apiData)
                await coreDataManager.saveToCoreData(products: apiData.products)
            } catch let error as ApiError {
                DispatchQueue.main.async {
                    self.handleApiError(error)
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = ErrorMessage(message: "Unexpected error occured: \(error.localizedDescription)")
                }
            }
        } else {
            print("Data is already saved in Core data. Loading data from Core data instead")
        }
    }
    
    func fetchProductsByCategory(category: String) -> [Products] {
        coreDataManager.fetchProductsByCategory(category: category)
    }
    
    func fetchAllCategories() async {
        DispatchQueue.main.async {
            self.categories = self.coreDataManager.fetchAllCategories()
            print("Fetched categories: \(self.categories)") // Do it in view model
        }
    }
    
    private func handleApiError(_ error: ApiError) {
        switch error{
        case .invalidUrl:
            errorMessage = ErrorMessage(message: "Invalid Url. Please try again later")
        case .invalidResponse:
            errorMessage = ErrorMessage(message: "Invalid response from the server")
        case .decodingError:
            errorMessage = ErrorMessage(message: "Failed to decode the response data from the server")
        case .badRequest(let msg):
            errorMessage = ErrorMessage(message: "Bad request: \(msg)")
        case .serverError(let msg):
            errorMessage = ErrorMessage(message: "Server Error: \(msg)")
        case .other(let msg):
            errorMessage = ErrorMessage(message: "Error: \(msg)")
        }
        
    }
}
