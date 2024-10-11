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
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(categories, id: \.self) { category in
                            let products = homeViewModel.fetchProductsByCategory(category: category)
                            if !products.isEmpty {
                                CategoryRowView(category: category, products: products, favProductsViewModel: favProductsViewModel)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
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
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(HomeView.Tab.home)
            
            // Favorites Tab
            NavigationStack {
                FavoriteView(favProductsViewModel: favProductsViewModel, selectedTab: $selectedTab)
                    .navigationTitle("WishList")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }
            .tag(HomeView.Tab.favorites)
            
            // Account Tab
            NavigationStack {
                Text("Account View")
                    .navigationTitle("Account")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Account", systemImage: "person.fill")
            }
            .tag(HomeView.Tab.account)
        }
        .accentColor(Color(hex: "#DB3022"))
    }
}
