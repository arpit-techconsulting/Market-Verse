//
//  ProductCardView.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/6/24.
//

import SwiftUI

struct ProductCardView: View {
    var product: Products
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageUrl = URL(string: product.thumbnail ?? "") {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .cornerRadius(5)
                } placeholder: {
                    Color.gray
                        .frame(width: 140, height: 140)
                        .cornerRadius(5)
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

