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

    var body: some Scene {
        WindowGroup {
            HomeView(favProductsViewModel: favProductsViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
