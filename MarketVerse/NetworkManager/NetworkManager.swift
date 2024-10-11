//
//  NetworkManager.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/2/24.
//

enum ApiError: Error {
    case invalidUrl
    case invalidResponse
    case decodingError
    case badRequest(String) // 400 status code range
    case serverError(String) // 500 status code range
    case other(String)
}

import Foundation

class NetworkManager {
    func apiCall<T: Decodable>(apiUrl: String, responseModel: T.Type) async throws -> T {
        guard let url = URL(string: apiUrl) else {
            throw ApiError.invalidUrl
        }
        
        let urlSession = URLSession.shared
        
        let (data, response) = try await urlSession.data(from: url)
        guard let _response = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        
        switch _response.statusCode {
        case 200:
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                throw ApiError.decodingError
            }
            
        case 400..<500:
            throw ApiError.badRequest("Client error: \(_response.statusCode)")
            
        case 500..<600:
            throw ApiError.serverError("500 Internal Server Error!! \(_response.statusCode)")
            
        default:
            throw ApiError.other("Unexpected Status Code: \(_response.statusCode)")
            
        }
    }
}
