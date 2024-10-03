//
//  Home.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/3/24.
//

import SwiftUI

struct Home: View {
    
    let homeViewModel = HomeVM()
    
    var body: some View {
        Text("Hello, World!")
        
            .onAppear {
                Task {
                    await homeViewModel.fetchApiData()
                }
            }
    }
}

#Preview {
    Home()
}
