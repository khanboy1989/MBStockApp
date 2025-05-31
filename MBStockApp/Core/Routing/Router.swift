//
//  Router.swift
//  MBStockApp
//
//  Created by Serhan Khan on 31/05/2025.
//

import Foundation
import SwiftUI

/// Router for keeping navigation state within whole app.
final class Router: ObservableObject {
    @Published var navPath = NavigationPath()
    public init() {}
    
    // Navigate to forward (push to stack)
    func navigate(to destination: any Hashable) {
        navPath.append(destination)
    }

    // Navigate back to previous screen
    func navigateBack() {
        navPath.removeLast()
    }

    // Navigat to root screen on stack
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
