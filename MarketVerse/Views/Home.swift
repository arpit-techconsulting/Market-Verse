//
//  Home.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/3/24.
//

import SwiftUI

import SwiftUI

struct Home: View {
    
    private let homeViewModel = HomeVM()
    
    var body: some View {
        TabView {
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
            
            // Favorites Tab
            Text("Favorites View")
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
            
            // Account Tab
            Text("Account View")
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
        }
    }
}

#Preview {
    Home()
}
