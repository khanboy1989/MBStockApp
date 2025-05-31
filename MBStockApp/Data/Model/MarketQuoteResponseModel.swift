//
//  MarketQuoteResponse.swift
//  MBStockApp
//
//  Created by Serhan Khan on 31/05/2025.
//

import Foundation

// MARK: - Root
struct MarketQuoteResponseModel: Decodable {
    let quoteResponse: QuoteResponse
}

// MARK: - QuoteResponse
struct QuoteResponse: Decodable {
    let result: [QuoteResult]
    let error: String? 
}

// MARK: - QuoteResult
struct QuoteResult: Decodable {
    let language: String?
    let region: String?
    let quoteType: String?
    let typeDisp: String?
    let quoteSourceName: String?
    let triggerable: Bool?
    let customPriceAlertConfidence: String?
    let currency: String?
    let symbol: String?
    let market: String?
    let exchange: String?
    let quoteSummary: QuoteSummary?
    let components: [String]?
    let priceHint: Int?
    let marketCap: Double?
    let regularMarketPrice: Double?
    let regularMarketChangePercent: Double?
    let regularMarketDayHigh: Double?
    let regularMarketDayLow: Double?
    let regularMarketVolume: Int?
    let regularMarketPreviousClose: Double?
    let regularMarketOpen: Double?
    let bid: Double?
    let ask: Double?
    let shortName: String?
    let longName: String?
    let trailingPE: Double?
    let forwardPE: Double?
    let bookValue: Double?
    let epsForward: Double?
    let epsCurrentYear: Double?
    let epsTrailingTwelveMonths: Double?
    let dividendRate: Double?
    let dividendYield: Double?
    let sharesOutstanding: Int64?
    let fiftyTwoWeekLow: Double?
    let fiftyTwoWeekHigh: Double?
    let averageDailyVolume10Day: Int?
    let averageDailyVolume3Month: Int?
    let marketState: String?
    let postMarketPrice: Double?
    let postMarketChangePercent: Double?
    let postMarketTime: Int64?
    let exchangeTimezoneName: String?
    let exchangeTimezoneShortName: String?
    let messageBoardId: String?
    let financialCurrency: String?
    let pageViews: PageViews?
}

// MARK: - QuoteSummary
struct QuoteSummary: Decodable {
    let summaryDetail: SummaryDetail?
    let earnings: Earnings?
}

// MARK: - SummaryDetail
struct SummaryDetail: Decodable {
    let maxAge: Int?
    let priceHint: Int?
    let previousClose: Double?
    let open: Double?
    let dayLow: Double?
    let dayHigh: Double?
    let regularMarketPreviousClose: Double?
    let regularMarketOpen: Double?
    let regularMarketDayLow: Double?
    let regularMarketDayHigh: Double?
    let exDividendDate: Int64?
    let payoutRatio: Double?
    let beta: Double?
    let trailingPE: Double?
    let forwardPE: Double?
    let volume: Int?
    let regularMarketVolume: Int?
    let averageVolume: Int?
    let bid: Double?
    let ask: Double?
    let bidSize: Int?
    let askSize: Int?
    let marketCap: Int64?
    let fiftyTwoWeekLow: Double?
    let fiftyTwoWeekHigh: Double?
    let currency: String?
    let tradeable: Bool?
}

// MARK: - Earnings
struct Earnings: Decodable {
    let maxAge: Int?
    let earningsChart: EarningsChart?
    let financialsChart: FinancialsChart?
    let financialCurrency: String?
}

// MARK: - EarningsChart
struct EarningsChart: Decodable {
    let quarterly: [QuarterlyEarnings]?
    let currentQuarterEstimate: Double?
    let currentQuarterEstimateDate: String?
    let currentQuarterEstimateYear: Int?
    let earningsDate: [Int64]?
    let isEarningsDateEstimate: Bool?
}

struct QuarterlyEarnings: Decodable {
    let date: String?
    let actual: Double?
    let estimate: Double?
}

// MARK: - FinancialsChart
struct FinancialsChart: Decodable {
    let yearly: [FinancialData]?
    let quarterly: [FinancialData]?
}

struct FinancialData: Decodable {
    let date: String  // Can be year (Int) or quarter string
    let revenue: Int64
    let earnings: Int64
}

// MARK: - PageViews
struct PageViews: Decodable {
    let midTermTrend: String?
    let longTermTrend: String?
    let shortTermTrend: String?
}
