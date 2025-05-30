//
//  MarketsDataSource.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//

import Foundation

protocol MarketDataSource {
    func fetchMarketSummary() async throws -> MarketSummaryAndSparkResponseModel
}

final class DefaultMarketDataSource: MarketDataSource {
    
    private let requestManager: RequestManager
    
    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }
    
    func fetchMarketSummary() async throws -> MarketSummaryAndSparkResponseModel {
        let request = MarketsRequest.summary
        let response: MarketSummaryAndSparkResponseModel = try await requestManager.makeRequest(with: request)
        return response
    }
}
