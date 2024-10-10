//
//  MarketVerseApp.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 9/30/24.
//

import SwiftUI

@main
struct MarketVerseApp: App {
    let persistenceController = PersistenceController.shared
    let favProductsViewModel = FavProductsViewModel()
    let homeViewModel = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView(homeViewModel: homeViewModel, favProductsViewModel: favProductsViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
