//
//  MarketSummaryViewModelTests.swift
//  MBStockApp
//
//  Created by Serhan Khan on 01/06/2025.
//

import XCTest
@testable import MBStockApp

@MainActor
final class MarketSummaryViewModelTests: XCTestCase {
    
    // MARK: - Properties -
    var sut: MarketSummaryViewModel!
    var getMarketSummaryUseCaseMock: GetMarketSummaryUseCaseMock!
    
    // MARK: - Setup and Teardown
    override func setUpWithError() throws {
        try super.setUpWithError()
        getMarketSummaryUseCaseMock = GetMarketSummaryUseCaseMock()
        sut = MarketSummaryViewModel(getMarketSummaryUseCase: getMarketSummaryUseCaseMock)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        getMarketSummaryUseCaseMock = nil
        sut = nil
    }
    
    // MARK: - Tests
    func testInitialState() {
        // Then
        XCTAssertEqual(sut.state, .initial)
    }
    
    func testGetMarketSummarySuccess() async {
        // When
        await sut.fetchMarketSummary(isRefreshing: false)
        
        // Then
        XCTAssertEqual(sut.state, .success)
        XCTAssertEqual(sut.summaries.count, 1)
        XCTAssertEqual(sut.summaries.first?.name, "NasdaqGS")
        XCTAssertEqual(sut.filteredSummaries.count, 1)
    }
    
    func testGetMarketSummaryFailure() async {
        // Given
        getMarketSummaryUseCaseMock.shouldFail = true
        
        // When
        await sut.fetchMarketSummary(isRefreshing: false)
        
        // Then
        XCTAssertEqual(sut.state, .error("noDataFound".localized()))
        XCTAssertTrue(sut.summaries.isEmpty)
        XCTAssertTrue(sut.filteredSummaries.isEmpty)
    }
    
    func testSearchTextFiltersSummaries() async {
        // Given
        let expectedSearchText = "NasdaqGS"
        
        // Simulate debounce
        try? await Task.sleep(nanoseconds: 350_000_000) // 350ms
        
        // When
        sut.searchText = expectedSearchText
        await sut.fetchMarketSummary(isRefreshing: false)
        
        // Then
        XCTAssertEqual(sut.filteredSummaries.count, 1)
        XCTAssertEqual(sut.filteredSummaries.first?.name, "NasdaqGS")
        XCTAssertEqual(sut.searchText, expectedSearchText)
        XCTAssertEqual(sut.state, .success)
    }
    
    func testEmptySearchTextReturnsAllSummaries() async {
        // Given
        let expectedSearchText = ""
        
        // Simulate debounce
        try? await Task.sleep(nanoseconds: 350_000_000) // 350ms
        
        // When
        sut.searchText = expectedSearchText
        await sut.fetchMarketSummary(isRefreshing: false)
        
        // Then
        XCTAssertEqual(sut.filteredSummaries.count, sut.summaries.count)
        XCTAssertEqual(sut.searchText, expectedSearchText)
        XCTAssertEqual(sut.state, .success)
    }
    
    func testStopAutoRefreshCancelsTimers() {
        // Given
        sut.startAutoRefresh()
        
        // When
        sut.stopAutoRefresh()
        
        // Then
        XCTAssertTrue(sut.cancellables.isEmpty)
    }
}
