//
//  Model.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/2/24.
//

import Foundation

struct ProdReviews: Decodable {
    let rating: Int64
    let comment: String
    let date: String
    let reviewerName: String
}

struct Dimensions: Decodable {
    let width: Double
    let height: Double
    let depth: Double
}

struct Prods: Decodable {
    let id: Int64
    let title: String
    let description: String
    let category: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let brand: String?
    let weight: Int64
    let dimensions: Dimensions
    let warrantyInformation: String
    let availabilityStatus: String
    let reviews: [ProdReviews]
    let returnPolicy: String
    let minimumOrderQuantity: Int64
    let images: [String]
    let thumbnail: String
}

struct Model: Decodable {
    let products: [Prods]
}
