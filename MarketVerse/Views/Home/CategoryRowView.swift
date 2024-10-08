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
    
    @ObservedObject var favProductsViewModel: FavProductsViewModel
    
    @State private var isSheetPresented = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(category.prefix(1).capitalized + category.dropFirst())
                    .font(.headline)
                Spacer()
                Button("VIEW ALL") {
                    isSheetPresented = true
                }
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 16) { // Use lazyHStack, lazyVStack...
                    ForEach(products, id: \.self) {product in
                        ProductCardView(product: product, favProductsViewModel: favProductsViewModel)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical, 8)
        .sheet(isPresented: $isSheetPresented) {
            ProductsGridView(category: category, products: products, favProductsViewModel: favProductsViewModel)
        }
    }
}
