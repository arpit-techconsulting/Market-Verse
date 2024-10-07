//
//  TabBarView.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/3/24.
//

import SwiftUI

// SubView
struct TabBarView: View {
    
    @Binding var selectedTab: HomeView.Tab
    var homeViewModel: HomeViewModel
    var categories: [String]
    
    @ObservedObject var favProductsViewModel: FavProductsViewModel
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(categories, id: \.self) {category in
                        let products = homeViewModel.fetchProductsByCategory(category: category)
                        if !products.isEmpty {
                            CategoryRowView(category: category, products: products, favProductsViewModel: favProductsViewModel)
                        }
                    }
                }
                .padding()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(HomeView.Tab.home)
            
            // Favorites Tab
            Text("Favorites View")
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
                .tag(HomeView.Tab.favorites)
            
            // Account Tab
            Text("Account View")
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
                .tag(HomeView.Tab.account)
        }
        .accentColor(Color.init(hex: "#DB3022"))
        
    }
}

//#Preview {
//    TabBarView(selectedTab: .constant(.home), homeViewModel: HomeVM())
//}
