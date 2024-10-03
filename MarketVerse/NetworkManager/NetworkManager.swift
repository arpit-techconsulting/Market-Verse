//
//  NetworkManager.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/2/24.
//

enum ApiError: Error {
    case invalidUrl
    case invalidResponse
    case other(String)
}

import Foundation

struct NetworkManager {
    func apiCall(apiUrl: String) async throws -> Model {
        guard let url = URL(string: apiUrl) else {
            throw ApiError.invalidUrl
        }
        
        let urlSession = URLSession.shared
        
        let (data, response) = try await urlSession.data(from: url)
        guard let _response = response as? HTTPURLResponse, _response.statusCode == 200 else {
            throw ApiError.invalidResponse
        }
        
        let allData = try JSONDecoder().decode(Model.self, from: data)
        return allData
    }
}
