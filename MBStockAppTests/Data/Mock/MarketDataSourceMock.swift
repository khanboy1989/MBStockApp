//
//  MarketDataSourceMock.swift
//  MBStockApp
//
//  Created by Serhan Khan on 31/05/2025.
//

import Foundation
@testable import MBStockApp

// MARK: - Mocked Market Data Source
final class MarketDataSourceMock: MarketDataSource {
    // MARK: - Methods -
    // fetchMarketSummary with mocked data
    func fetchMarketSummary(region: String) async throws -> MarketSummaryAndSparkResponseModel {
        return MarketSummaryAndSparkResponseModel(
            marketSummaryAndSparkResponse: MarketSummaryAndSparkModel(
                result: [
                    MarketResult(
                        fullExchangeName: "NasdaqGS",
                        symbol: "AAPL",
                        gmtOffSetMilliseconds: -14400000,
                        language: "en-US",
                        regularMarketTime: TimeData(raw: 1717142400, fmt: "2025-05-31T15:00:00Z"),
                        quoteType: "EQUITY",
                        spark: SparkData(
                            timestamp: [1717142100, 1717142160, 1717142220],
                            symbol: "AAPL",
                            end: 1717142280,
                            previousClose: 189.98,
                            chartPreviousClose: 189.98,
                            close: [190.00, 191.20, 191.80],
                            start: 1717142100,
                            dataGranularity: 60
                        ),
                        regularMarketPrice: PriceData(raw: 191.80, fmt: "191.80")
                    )
                ],
                error: nil
            )
        )
    }
    
    // fetchMarketQuotes with mocked data
    func fetchMarketQuotes(region: String, symbol: String) async throws -> MarketQuoteResponseModel {
        return MarketQuoteResponseModel(
            quoteResponse: QuoteResponse(
                result: [
                    QuoteResult(
                        language: "en-US",
                        region: region,
                        quoteType: "EQUITY",
                        typeDisp: "Equity",
                        quoteSourceName: "Nasdaq Real Time Price",
                        triggerable: true,
                        customPriceAlertConfidence: "HIGH",
                        currency: "USD",
                        symbol: symbol,
                        market: "us_market",
                        exchange: "NMS",
                        quoteSummary: nil,
                        components: nil,
                        priceHint: 2,
                        marketCap: 2800000000000,
                        regularMarketPrice: 191.80,
                        regularMarketChangePercent: 1.2,
                        regularMarketDayHigh: 192.50,
                        regularMarketDayLow: 189.90,
                        regularMarketVolume: 62000000,
                        regularMarketPreviousClose: 189.98,
                        regularMarketOpen: 190.00,
                        bid: 191.75,
                        ask: 191.85,
                        shortName: "Apple Inc.",
                        longName: "Apple Incorporated",
                        trailingPE: 28.5,
                        forwardPE: 26.1,
                        bookValue: 4.5,
                        epsForward: 7.15,
                        epsCurrentYear: 6.8,
                        epsTrailingTwelveMonths: 6.73,
                        dividendRate: 0.92,
                        dividendYield: 0.45,
                        sharesOutstanding: 15500000000,
                        fiftyTwoWeekLow: 140.50,
                        fiftyTwoWeekHigh: 198.75,
                        averageDailyVolume10Day: 70000000,
                        averageDailyVolume3Month: 68000000,
                        marketState: "REGULAR",
                        postMarketPrice: 192.00,
                        postMarketChangePercent: 0.1,
                        postMarketTime: 1717150000,
                        exchangeTimezoneName: "America/New_York",
                        exchangeTimezoneShortName: "EST",
                        messageBoardId: "finmb_24937",
                        financialCurrency: "USD",
                        pageViews: PageViews(
                            midTermTrend: "UP",
                            longTermTrend: "UP",
                            shortTermTrend: "NEUTRAL"
                        )
                    )
                ],
                error: nil
            )
        )
    }
}
