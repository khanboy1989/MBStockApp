//
//  DefaultMarketRepositoryTests.swift
//  MBStockApp
//
//  Created by Serhan Khan on 31/05/2025.
//

import XCTest
@testable import MBStockApp

final class DefaultMarketRepositoryTests: XCTestCase {
    // MARK: - Properties -
    
    var sut: DefaultMarketRepository!
    var dataSourceMock: MarketDataSourceMock!
   
    // MARK: - setupWithError
    override func setUpWithError() throws {
        try super.setUpWithError()
        dataSourceMock = MarketDataSourceMock()
        sut = DefaultMarketRepository(marketDataSource: dataSourceMock)
    }
    
    // MARK: - tearDownWithError -
    override func tearDownWithError() throws {
        sut = nil
        dataSourceMock = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Tests
    func testFetchingMarketSummarySuccess() async {
       let result = await sut.getMarketSummary(region: "US")
        switch result {
        case let .success(marketSummary):
            XCTAssertEqual(marketSummary.first?.id, "AAPL")
        case let .failure(error):
            XCTFail("\(error)")
        }
    }
    
    func testFetchingMarketQuoteSuccess() async {
        let result = await sut.getMarketQuote(region: "US", symbol: "AAPL")
        switch result {
        case let .success(marketQuote):
            XCTAssertEqual(marketQuote.volume, 62000000)
        case let .failure(error):
            XCTFail("\(error)")
        }
    }
}
