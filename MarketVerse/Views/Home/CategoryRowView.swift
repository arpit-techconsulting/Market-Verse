//
//  CategoryRowView.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/6/24.
//

import SwiftUI

struct CategoryRowView: View {
    var category: String
    var products: [Products]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(category.prefix(1).capitalized + category.dropFirst())
                    .font(.headline)
                Spacer()
                Button("VIEW ALL") {
                    
                }
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(products, id: \.self) {product in
                        ProductCardView(product: product)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical, 8)
    }
}
