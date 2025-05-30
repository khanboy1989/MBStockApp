//
//  GetMarketSummaryUC.swift
//  MBStockApp
//
//  Created by Serhan Khan on 30/05/2025.
//

import Foundation

// MARK: - Protocol
protocol GetMarketSummaryUC {
    func execute() async -> Result<[MarketSummary], AppError>
}

// MARK: - Implementation
final class DefaultGetMarketSummaryUC: GetMarketSummaryUC {
    
    private let repository: MarketRepository
    
    init(repository: MarketRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<[MarketSummary], AppError> {
        return await repository.getMarketSummary()
    }
}
