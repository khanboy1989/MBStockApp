//
//  Market.swift
//  MBStockApp
//
//  Created by Serhan Khan on 01/06/2025.
//

import XCTest
@testable import MBStockApp

// MARK: - MarketQuoteDetailViewModelTests -
@MainActor
final class MarketQuoteDetailViewModelTests: XCTestCase {
    
    // MARK: - Properties 
    var sut: MarketQuoteDetailViewModel!
    var getMarketQuoteDetailUseCaseMock: GetMarketQuoteUseCaseMock!
    
    // MARK: - Setup and TearDown
    override func setUpWithError() throws {
        try super.setUpWithError()
        getMarketQuoteDetailUseCaseMock = GetMarketQuoteUseCaseMock()
        sut = MarketQuoteDetailViewModel(getMarketQuoteUC: getMarketQuoteDetailUseCaseMock)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        getMarketQuoteDetailUseCaseMock = nil
        try? super.tearDownWithError()
    }
    
    // MARK: - Tests -
    func testInitialState() {
        // Then
        XCTAssertEqual(sut.state, .initial)
    }
    
    func testGetMarketQuoteSuccess() async {
        // Given
        let region = "US"
        let symbol = "MSFT"
        
        // When
        await sut.getMarketQuote(region: region, symbol: symbol)
        
        // Then
        XCTAssertEqual(sut.state, .success)
        XCTAssertEqual(sut.marketQuote?.shortName, "Apple Inc.")
    }
    
    func testGetMarketQuoteFailure() async {
        // Given
        let region = "US"
        let symbol = "MSFT"
        getMarketQuoteDetailUseCaseMock.shouldFail = true 
        
        // When
        await sut.getMarketQuote(region: region, symbol: symbol)
        
        // Then
        XCTAssertEqual(sut.marketQuote, nil)
        XCTAssertEqual(sut.state, .error("noDataFound".localized()))
    }
}
