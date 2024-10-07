//
//  FavoriteView.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/7/24.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var favProductsViewModel: FavProductsViewModel

        private let columns = [
            GridItem(.flexible(), spacing: 5),
            GridItem(.flexible(), spacing: 5)
        ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(favProductsViewModel.favoriteProducts.keys.sorted(), id: \.self) { productID in
                        if let product = favProductsViewModel.getProductByID(productID: productID) {
                            ProductCardView(product: product, favProductsViewModel: favProductsViewModel)
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
