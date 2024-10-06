//
//  Home.swift
//  MarketVerse
//
//  Created by Arpit Mallick on 10/3/24.
//

import SwiftUI

struct Home: View {
    
    private let homeViewModel = HomeVM()
    
    var body: some View {
        Text("Hello, World!")
        
            .onAppear {
                let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
                print(paths[0])
                Task {
                    await homeViewModel.fetchApiData()
                }
            }
    }
}

#Preview {
    Home()
}
