//
//  MarketQuote.swift
//  MBStockApp
//
//  Created by Serhan Khan on 31/05/2025.
//

import Foundation

struct MarketQuote: Equatable {
    let symbol: String                  // e.g., "AAPL" – Ticker symbol to identify the company
    let shortName: String              // e.g., "Apple Inc." – For display in the UI
    let price: Double                  // Current stock price
    let changePercent: Double          // Percentage change from previous close (visual trend ↑/↓)
    let currency: String?              // e.g., "USD" – Display currency unit
    let marketCap: Double?             // Company's total valuation (e.g., $2.3T) – shown in detail
    let volume: Int?                   // Current trading volume – indicates activity level
    let peRatio: Double?               // Price-to-Earnings ratio – used in valuation analysis
    let eps: Double?                   // Earnings per share – core profitability metric
    let open: Double?                  // Market opening price – shows intraday movement
    let dayHigh: Double?               // Highest price today – part of price range info
    let dayLow: Double?                // Lowest price today – part of price range info
    let fiftyTwoWeekHigh: Double?      // 52-week high – used for high/low performance visual
    let fiftyTwoWeekLow: Double?       // 52-week low – used for high/low performance visual
}
