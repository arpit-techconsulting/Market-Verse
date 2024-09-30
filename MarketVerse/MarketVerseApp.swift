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
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
