//
//  DefaultMarketRepository.swift
//  MBStockApp
//
//  Created by Serhan Khan on 30/05/2025.
//

import Foundation

final class DefaultMarketRepository: MarketRepository {
    private let marketDataSource: MarketDataSource
    
    init(marketDataSource: MarketDataSource) {
        self.marketDataSource = marketDataSource
    }
    
    func getMarketSummary(region: String) async -> Result<[MarketSummary], AppError> {
        do {
            let data = try await marketDataSource.fetchMarketSummary(region: region)
            let marketSummaries = data.marketSummaryAndSparkResponse.result.map {
                $0.toDomain()
            }
            return .success(marketSummaries)
        } catch {
            return .failure(error.toAppError)
        }
    }
}
