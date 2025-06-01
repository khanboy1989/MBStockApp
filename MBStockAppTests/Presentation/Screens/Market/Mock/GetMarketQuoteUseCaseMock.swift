//
//  GetMarketQuoteUseCaseMock.swift
//  MBStockApp
//
//  Created by Serhan Khan on 01/06/2025.
//

import Foundation
@testable import MBStockApp

// MARK: - GetMarketSummaryUseCaseMock -
final class GetMarketQuoteUseCaseMock: GetMarketQuoteUC {
    
    var shouldFail: Bool = false
    
    // MARK: - Properties -
    private let mockMarketRepository: MarketRepositoryMock!
  
    // MARK: - Init -
    init() {
        mockMarketRepository = MarketRepositoryMock()
    }
    
    // MARK: - Mocked Methods -
    func execute(_ region: String, symbol: String) async -> Result<MarketQuote, AppError> {
        if shouldFail {
            return .failure(.networkError("noDataFound".localized()))
        } else {
            return await mockMarketRepository.getMarketQuote(region: region, symbol: symbol)
        }
    }
}
