//
//  Resolver.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//

import Foundation
import Swinject

/// Resolver is a singleton class that is repsonbile for injecting all dependecies in the app
/// .inObjectScope(.container): Ensures each service is a singleton within the app lifecycle.
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
        guard let resolved = container.resolve(T.self) else {
            fatalError("Dependency of type \(T.self) not registered.")
        }
        return resolved
    }
}

// MARK: - Injecting DataSources -
extension Resolver {
    private func injectUtils() {
        //NetworkManager: Registers a singleton instance of DefaultNetworkManager.
        container.register(NetworkManager.self) { _ in
            DefaultNetworkManager()
        }.inObjectScope(.container)
        
        // RequestManager: Depends on NetworkManager, so it resolves that first.
        container.register(RequestManager.self) { resolver in
            DefaultRequestManager(networkManager: resolver.resolve(NetworkManager.self)!)
        }
        .inObjectScope(.container)
    }
}

// MARK: - Injecting DataSources -
extension Resolver {
    private func injectDataSources() {
        container.register(MarketDataSource.self) { resolver in
            DefaultMarketDataSource(requestManager: resolver.resolve(RequestManager.self)!)
        }
        .inObjectScope(.container)
    }
}

// MARK: - Injecting Repositories -
extension Resolver {
    private func injectRepositories() {
        container.register(MarketRepository.self) { resolver in
            DefaultMarketRepository(marketDataSource: resolver.resolve(MarketDataSource.self)!)
        }
        .inObjectScope(.container)
    }
}

// MARK: - Injecting Use Cases -
extension Resolver {
    private func injectUseCases() {
        container.register(GetMarketSummaryUC.self) { resolver in
            DefaultGetMarketSummaryUC(repository: resolver.resolve(MarketRepository.self)!)
        }.inObjectScope(.container)
    }
}

// MARK: - Injecting ViewModels -

extension Resolver {
    @MainActor
    private func injectViewModels() {
    }
}
