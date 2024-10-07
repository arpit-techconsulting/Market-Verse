//
//  FavoriteView.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/7/24.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var favProductsViewModel: FavProductsViewModel
    @Binding var selectedTab: HomeView.Tab

        private let columns = [
            GridItem(.flexible(), spacing: 5),
            GridItem(.flexible(), spacing: 5)
        ]

    var body: some View {
        NavigationView {
            ScrollView {
                if favProductsViewModel.favoriteProducts.isEmpty {
                    VStack(spacing: 20) {
                        Text("Nothing saved yet")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 100)
                        
                        Button(action: {
                            selectedTab = .home
                        }) {
                            HStack {
                                Spacer()
                                Text("Start Shopping")
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .foregroundStyle(.black)
                            }
                            .padding()
                            .background(Color(hex: "#DB3022"))
                            .cornerRadius(10)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 40)
                    }
                } else {
                    LazyVGrid(columns: columns, spacing: 5) {
                        ForEach(favProductsViewModel.favoriteProducts.keys.sorted(), id: \.self) { productID in
                            if let product = favProductsViewModel.getProductByID(productID: productID) {
                                ProductCardView(product: product, favProductsViewModel: favProductsViewModel)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
