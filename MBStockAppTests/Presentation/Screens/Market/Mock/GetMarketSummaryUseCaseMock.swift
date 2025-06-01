//
//  GetMarketSummaryUseCaseMock.swift
//  MBStockApp
//
//  Created by Serhan Khan on 01/06/2025.
//

import Foundation
@testable import MBStockApp

// MARK: - GetMarketSummaryUseCaseMock -
final class GetMarketSummaryUseCaseMock: GetMarketSummaryUC {
   
    var shouldFail: Bool = false
    
    // MARK: - Properties -
    private let mockMarketRepository: MarketRepositoryMock!
  
    // MARK: - Init -
    init() {
        mockMarketRepository = MarketRepositoryMock()
    }
    
    // MARK: - Mocked Methods -
    func execute(_ region: String) async -> Result<[MarketSummary], AppError> {
        if shouldFail {
            return .failure(.networkError("noDataFound".localized()))
        } else {
            return await mockMarketRepository.getMarketSummary(region: region)
        }
    }
}
