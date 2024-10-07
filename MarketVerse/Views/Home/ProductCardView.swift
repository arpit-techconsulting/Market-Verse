//
//  ProductCardView.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/6/24.
//

import SwiftUI

struct ProductCardView: View {
    @State private var isFavorite = false
    var product: Products
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                if let imageUrl = URL(string: product.thumbnail ?? "") {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160, height: 160)
                            .cornerRadius(5)
                    } placeholder: {
                        Color.gray
                            .frame(width: 160, height: 160)
                            .cornerRadius(5)
                    }
                }
                
                Button(action: {
                    isFavorite.toggle()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(8)
                        .foregroundColor(isFavorite ? .red : .gray)
                        .background(Color.white.opacity(0.7))
                        .clipShape(Circle())
                        .padding([.top, .trailing], 8)
                }
            }
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
        }
        .padding()
        .cornerRadius(10)
        .frame(width: 160)
        //        .padding(.trailing, 4)
    }
}

