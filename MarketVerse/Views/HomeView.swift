//
//  Home.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/3/24.
//

import SwiftUI

struct HomeView: View {
    
    private let homeViewModel = HomeVM()
    @State private var selectedTab: Tab = .home

    enum Tab {
        case home
        case favorites
        case account
    }
    
    var body: some View {
        NavigationView {
            TabBarView(selectedTab: $selectedTab, homeViewModel: homeViewModel)
                .navigationTitle(navigationTitle(for: selectedTab))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if selectedTab == .home {
                            Button(action: {
                                // Action for cart icon button
                                print("Cart icon tapped")
                            }) {
                                Image(systemName: "cart")
                            }
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
            return "Favorites"
        case .account:
            return "Account"
        }
    }
}

#Preview {
    HomeView()
}
