//
//  TabBarView.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/3/24.
//

import SwiftUI

struct TabBarView: View {
    
    @Binding var selectedTab: HomeView.Tab
    var homeViewModel: HomeVM
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            VStack {
                Text("Home View")
                    .onAppear {
                        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
                        print(paths[0])
                        Task {
                            await homeViewModel.fetchApiData()
                        }
                    }
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
    }
}

//#Preview {
//    TabBarView(selectedTab: .constant(.home), homeViewModel: HomeVM())
//}
