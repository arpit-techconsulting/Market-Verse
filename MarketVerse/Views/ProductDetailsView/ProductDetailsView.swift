//
//  ProductDetailsView.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/7/24.
//

import SwiftUI

struct ProductDetailsView: View {
    @ObservedObject var favProductsViewModel: FavProductsViewModel
    var product: Products
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                // Image slider using tabView
                TabView {
                    if let images = product.img?.allObjects as? [Images] {
                        ForEach(images, id: \.self) {image in
                            if let imageUrl = URL(string: image.img_url ?? "") {
                                AsyncImage(url: imageUrl) {phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: .infinity, maxHeight: 300)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            }
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(height: 300)
                
                //Product Title
                Text(product.title ?? "Unknown")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 8)
                
                //Brand
                Text(product.brand ?? "Unknown")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                //Price and discount
                HStack(spacing: 8) {
                    
                    Text("$\(String(format: "%.2f", product.price))")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text("$\(String(format: "%.2f", product.price / (1 - product.discPerc / 100)))")
                        .font(.subheadline)
                        .strikethrough()
                        .foregroundColor(.gray)
                    
                    Text("\(String(format: "%.0f", product.discPerc))% OFF")
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "#DB3022"))
                }
                .padding(.vertical, 8)
                
                Divider()
                
                //Product Details
                Text("Product Details")
                    .font(.headline)
                    .padding(.bottom, 4)
                
                Text(product.desc ?? "No product description available.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.bottom, 16)
            }
            .padding(.horizontal)
        }
        .navigationTitle(product.title ?? "Product Details")
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    favProductsViewModel.toggleFavoriteStatus(productID: Int(product.prod_id))
                }) {
                    Image(systemName: favProductsViewModel.isFavorite(productID: Int(product.prod_id)) ? "heart.fill" : "heart")
                        .foregroundColor(favProductsViewModel.isFavorite(productID: Int(product.prod_id)) ? .red : .gray)
                }
            }
        }
    }
}
