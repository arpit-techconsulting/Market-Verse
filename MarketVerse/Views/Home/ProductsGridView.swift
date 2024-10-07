//
//  ProductsGridView.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/7/24.
//

import SwiftUI

struct ProductsGridView: View {
    var category: String
    var products: [Products]
    @ObservedObject var favProductsViewModel: FavProductsViewModel
    
    private let columns = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(products, id: \.self) {product in
                        ProductCardView(product: product, favProductsViewModel: favProductsViewModel)
                    }
                }
                .padding()
            }
            .navigationTitle(category.prefix(1).capitalized + category.dropFirst())
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
