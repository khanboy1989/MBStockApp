//
//  MBStockAppApp.swift
//  MBStockApp
//
//  Created by Serhan Khan on 28/05/2025.
//

import SwiftUI

@main
struct MBStockAppApp: App {
    
    init () {
        /// Injecting all dependencies
        Resolver.shared.injectModules()
    }
    
    var body: some Scene {
        WindowGroup {
            MarketSummaryView()
        }
    }
}
