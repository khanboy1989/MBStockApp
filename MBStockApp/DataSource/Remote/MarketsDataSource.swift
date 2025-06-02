//
//  MarketsDataSource.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//

import Foundation

/// Protocol defining the data source interface for fetching market data.
protocol MarketDataSource {
    
    /// Fetches market summary and spark data for a specific region.
    /// - Parameter region: The market region (e.g., "US", "EU").
    /// - Returns: A decoded `MarketSummaryAndSparkResponseModel`.
    func fetchMarketSummary(region: String) async throws -> MarketSummaryAndSparkResponseModel
    
    /// Fetches detailed market quote information for a specific symbol within a region.
    /// - Parameters:
    ///   - region: The market region.
    ///   - symbol: The stock or asset symbol (e.g., "AAPL", "GOOG").
    /// - Returns: A decoded `MarketQuoteResponseModel`.
    func fetchMarketQuotes(region: String, symbol: String) async throws -> MarketQuoteResponseModel
}

/// Default implementation of `MarketDataSource` using a request manager to make API calls.
final class DefaultMarketDataSource: MarketDataSource {

    /// Responsible for handling the actual API requests.
    private let requestManager: RequestManager
    
    /// Initializes the data source with a request manager.
    /// - Parameter requestManager: An instance responsible for making network requests.
    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }
    
    /// Fetches market summary and spark data from the network.
    /// - Parameter region: The market region (e.g., "US").
    /// - Returns: Parsed `MarketSummaryAndSparkResponseModel` from the API.
    func fetchMarketSummary(region: String) async throws -> MarketSummaryAndSparkResponseModel {
        let request = MarketsRequest.summary(region: region)
        let response: MarketSummaryAndSparkResponseModel = try await requestManager.makeRequest(with: request)
        return response
    }
    
    /// Fetches quote data for a specific symbol in a region from the network.
    /// - Parameters:
    ///   - region: The region to fetch the data from.
    ///   - symbol: The asset or stock symbol (e.g., "TSLA").
    /// - Returns: Parsed `MarketQuoteResponseModel` from the API.
    func fetchMarketQuotes(region: String, symbol: String) async throws -> MarketQuoteResponseModel {
        let request = MarketsRequest.quotes(region: region, symbol: symbol)
        let response: MarketQuoteResponseModel = try await requestManager.makeRequest(with: request)
        return response
    }
}
