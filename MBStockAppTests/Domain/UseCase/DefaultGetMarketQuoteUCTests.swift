//
//  DefaultGet.swift
//  MBStockApp
//
//  Created by Serhan Khan on 01/06/2025.
//

import XCTest
@testable import MBStockApp

final class DefaultGetMarketQuoteUCTests: XCTestCase {

    var sut: DefaultGetMarketQuoteUC!
    var repositoryMock: MarketRepositoryMock!
    
    // MARK: - setupWithError
    override func setUpWithError() throws {
        try super.setUpWithError()
        repositoryMock = MarketRepositoryMock()
        sut = DefaultGetMarketQuoteUC(repository: repositoryMock)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        repositoryMock = nil
        try super.tearDownWithError()
    }
    
    // MARK: - tearDownWithError
    func testExecuteSuccess() async {
        // Given
        let region = "US"
        let symbol = "AAPL"
        
        // Where
        let result = await sut.execute(region, symbol: symbol)
        
        // Then
        switch result {
        case let .success(quote):
            XCTAssertEqual(quote.shortName, "Apple Inc.")
        case let .failure(error):
            XCTFail("Unexpected error case :\(error.localizedDescription)")
        }
    }
    
    func testExecuteFailure() async {
        // Given
        let region = "US"
        let symbol = "AAPL"
        
        repositoryMock.shouldFailGetQuote = true
        
        // Where
        let result = await sut.execute(region, symbol: symbol)
        
        // Then
        switch result {
        case .success(_):
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
