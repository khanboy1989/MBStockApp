//
//  MBStockAppApp.swift
//  MBStockApp
//
//  Created by Serhan Khan on 28/05/2025.
//

import SwiftUI

@main
struct MBStockAppApp: App {
    @StateObject private var router: Router
    init () {
        /// Injecting all dependencies
        Resolver.shared.injectModules()
        
        /// Initialising the router env variable for app life cycle
        self._router = .init(wrappedValue: Resolver.shared.resolve(Router.self))
        
        /// Set appearance to dark
        UIView.appearance().overrideUserInterfaceStyle = .dark

    }
    
    var body: some Scene {
        WindowGroup {
            MarketSummaryView()
                .environmentObject(router)
        }
    }
}
