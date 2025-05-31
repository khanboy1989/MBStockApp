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
    
    func getMarketQuote(region: String, symbol: String) async -> Result<MarketQuote, AppError> {
        do {
            let data = try await marketDataSource.fetchMarketQuotes(region: region, symbol: symbol)
            guard let marketQuote = data.quoteResponse.result.first(where: {$0.symbol == symbol })?.toDomain() else {
                return .failure(.emptyDataError("noDataFound".localized()))
            }
            return .success(marketQuote)
        } catch {
            return .failure(error.toAppError)
        }
    }
}
