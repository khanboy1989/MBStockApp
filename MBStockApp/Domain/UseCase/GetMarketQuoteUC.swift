//
//  GetMarketQuoteUC.swift
//  MBStockApp
//
//  Created by Serhan Khan on 31/05/2025.
//

import Foundation

// MARK: - Protocol -
protocol GetMarketQuoteUC {
    func execute(_ region: String, symbol: String) async -> Result<MarketQuote, AppError>
}

// MARK: - Implementation
final class DefaultGetMarketQuoteUC: GetMarketQuoteUC {
    
    private let repository: MarketRepository
    
    init(repository: MarketRepository) {
        self.repository = repository
    }
    
    func execute(_ region: String, symbol: String) async -> Result<MarketQuote, AppError> {
        return  await repository.getMarketQuote(region: region, symbol: symbol)
    }
}
