//
//  ProductCardView.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/6/24.
//

import SwiftUI

struct ProductCardView: View {
    var product: Products
    @ObservedObject var favProductsViewModel: FavProductsViewModel
    
    var body: some View {
        NavigationLink(destination: ProductDetailsView(favProductsViewModel: favProductsViewModel, product: product)) {
            VStack(alignment: .leading, spacing: 8) {
                ZStack(alignment: .topTrailing) {
                    if let imageUrl = URL(string: product.thumbnail ?? "") {
                        AsyncImage(url: imageUrl) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 160, height: 160)
                                    .cornerRadius(5)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 160, height: 160)
                                    .cornerRadius(5)
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 160, height: 160)
                                    .cornerRadius(5)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                    
                    // Favorite button on top right corner
                    Button(action: {
                        favProductsViewModel.toggleFavoriteStatus(productID: Int(product.prod_id))
                    }) {
                        Image(systemName: favProductsViewModel.isFavorite(productID: Int(product.prod_id)) ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(8)
                            .foregroundColor(favProductsViewModel.isFavorite(productID: Int(product.prod_id)) ? .red : .gray)
                            .background(Color.white.opacity(0.7))
                            .clipShape(Circle())
                            .padding([.top, .trailing], 8)
                    }
                }
                
                // Product title and details
                Text(product.title ?? "Unknown")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .lineLimit(2)
                Text("Brand: \(product.brand ?? "Unknown")")
                    .font(.caption)
                    .lineLimit(1)
                Text("Price: $\(String(format: "%.2f", product.price))")
                    .font(.caption)
                    .lineLimit(1)
                Text("\(String(format: "%.2f", product.discPerc))% OFF")
                    .foregroundColor(Color.init(hex: "#DB3022"))
                    .font(.caption)
                    .lineLimit(1)
                
                // Add to Bag Button
                Button(action: {
                    print("Add to cart button tapped")
                }) {
                    HStack {
                        Spacer()
                        Text("Add to Bag")
                            .font(.system(size: 12))
                            .lineLimit(1)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Spacer()
                        Image(systemName: "bag")
                            .font(.system(size: 12))
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .background(Color(hex: "#DB3022"))
                    .cornerRadius(5)
                }
            }
            .padding()
            .cornerRadius(10)
            .frame(width: 160)
        }
        .buttonStyle(PlainButtonStyle()) // Ensure the button style doesn't interfere with the design
    }
}

