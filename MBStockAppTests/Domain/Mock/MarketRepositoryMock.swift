//
//  MarketRepositoryMock.swift
//  MBStockApp
//
//  Created by Serhan Khan on 01/06/2025.
//

import Foundation
@testable import MBStockApp

// MARK: - MarketRepositoryMock -
final class MarketRepositoryMock: MarketRepository {
    
    // MARK: - Properties -
    private let mockMarketSummaryData: MarketDataSourceMock!
    
    // For failing scenarios
    var shouldFailGetMarketSummer: Bool = false
    var shouldFailGetQuote: Bool = false
   
    // MARK: - Init -
    init() {
        self.mockMarketSummaryData = MarketDataSourceMock()
    }
    
    // MARK: - Mocked Methods -
    func getMarketSummary(region: String) async -> Result<[MarketSummary], AppError> {
        // For failing intentionally
        guard !shouldFailGetMarketSummer else {
            return .failure(.networkError("noDataFound".localized()))
        }
        
        do {
            let data = try await mockMarketSummaryData.fetchMarketSummary(region: region)
            let marketSummaries = data.marketSummaryAndSparkResponse.result.map {
                $0.toDomain()
            }
            return .success(marketSummaries) // return success response
        } catch {
            return .failure(error.toAppError) // map network error to AppError for UI
        }
    }
    
    func getMarketQuote(region: String, symbol: String) async -> Result<MarketQuote, AppError> {
        guard !shouldFailGetQuote else {
            return .failure(.networkError("noDataFound".localized()))
        }
        do {
            let data = try await mockMarketSummaryData.fetchMarketQuotes(region: region, symbol: symbol)
            guard let marketQuote = data.quoteResponse.result.first(where: {$0.symbol == symbol })?.toDomain() else {
                return .failure(.emptyDataError("noDataFound".localized()))
            }
            return .success(marketQuote) // otherwise return success
        } catch {
            return .failure(error.toAppError) // map network error to AppError for UI
        }
    }
}
