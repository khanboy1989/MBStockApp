//
//  GetMarketSummaryUCTests.swift
//  MBStockApp
//
//  Created by Serhan Khan on 01/06/2025.
//

import Foundation
import XCTest
@testable import MBStockApp

final class DefaultGetMarketSummaryUCTests: XCTestCase {
    
    var sut: DefaultGetMarketSummaryUC!
    var repositoryMock: MarketRepositoryMock!
    
    // MARK: - setupWithError
    override func setUpWithError() throws {
        try super.setUpWithError()
        repositoryMock = MarketRepositoryMock()
        sut = DefaultGetMarketSummaryUC(repository: repositoryMock)
    }
    
    // MARK: - tearDownWithError
    override func tearDownWithError() throws {
        sut = nil
        repositoryMock = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Tests
    func testExecuteSuccess() async {
        // Given
        let region = "US"
            
        // When
        let result = await sut.execute(region)
        
        // Then
        
        switch result {
        case .success(let marketSummary):
            XCTAssertEqual(marketSummary.first?.id, "AAPL")
        case .failure:
            XCTFail("Unexpected failure case")
        }
    }
    
    func testExecuteFailure() async {
        // Given
        let region = "US"
        repositoryMock.shouldFailGetMarketSummer = true
            
        // When
        let result = await sut.execute(region)
        
        // Then
        switch result {
        case let .success(marketSummary):
            XCTFail("Unexpected success case")
        case let .failure(error):
            switch error {
            case let .networkError(message):
                XCTAssertEqual(message, "noDataFound".localized())
            default:
                XCTFail("Unexpected error case")
            }
        }
    }
}
