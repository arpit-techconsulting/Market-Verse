//
//  Home.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/3/24.
//

import SwiftUI

// Parent View
struct HomeView: View {
    
    private let homeViewModel = HomeViewModel()
    @State private var selectedTab: Tab = .home
    @State private var categories: [String] = []
    
    @ObservedObject var favProductsViewModel: FavProductsViewModel

    enum Tab {
        case home
        case favorites
        case account
    }
    
    var body: some View {
        NavigationView {
            TabBarView(selectedTab: $selectedTab, homeViewModel: homeViewModel, categories: categories, favProductsViewModel: favProductsViewModel)
                .navigationTitle(navigationTitle(for: selectedTab))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if selectedTab == .home {
                            Button(action: {
                                // Action for cart icon button
                                print("Cart icon tapped")
                            }) {
                                Image(systemName: "cart.fill")
                                    .accentColor(Color(hex: "#edc240"))
                            }
                        }
                    }
                }
                .onAppear() {
                    let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
                    print(paths[0])
                    
                    Task {
                        await homeViewModel.fetchApiData()
                        DispatchQueue.main.async {
                            categories = homeViewModel.fetchAllCategories()
                            print("Fetched categories after API call: \(categories)")
                        }
                    }
    
                }
        }
    }
    
    private func navigationTitle(for tab: Tab) -> String {
        switch tab {
        case .home:
            return "Home"
        case .favorites:
            return "WishList"
        case .account:
            return "Account"
        }
    }
}

#Preview {
    let previewFavProductsViewModel = FavProductsViewModel()
    return HomeView(favProductsViewModel: previewFavProductsViewModel)
}
