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

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
