//
//  Resolver.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//

import Foundation
import Swinject

/// Resolver is a singleton class that is repsonbile for injecting all dependecies in the app
class Resolver {

    /// The shared instance of the resolver
    static let shared = Resolver()
    
    /// The container that holds all dependecies
    private var container = Container()
    
    /// This method is responsible for injecting all dependecies in the app
    ///
    /// > It should be called only once in the app's lifecycle
    @MainActor func injectModules() {
        injectUtils()
        injectDataSources()
        injectRepositories()
        injectUseCases()
        injectViewModels()
    }
    
    /// This method is responsible for resolving a dependency
    ///
    /// - Parameter type: The type of the dependency to be resolved
    /// - Returns: The resolved dependency
    func resolve<T>(_ type: T.Type) -> T {
        return container.resolve(T.self)!
    }
}

// MARK: - Injecting DataSources -
extension Resolver {
    private func injectUtils() {
        
    }
}

extension Resolver {
    private func injectDataSources() {
        
    }
}

extension Resolver {
    private func injectRepositories() {
        
    }
}

extension Resolver {
    private func injectUseCases() {
    }
}

// MARK: - Injecting ViewModels -

extension Resolver {
    @MainActor
    private func injectViewModels() {
    }
}
