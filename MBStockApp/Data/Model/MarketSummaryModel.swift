//
//  MarketSummaryAndSparkModel.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//

import Foundation

struct MarketSummaryAndSparkModel: Decodable {
    let result: [MarketResult]
    let error: String?
}

struct MarketResult: Decodable {
    let fullExchangeName: String
    let symbol: String
    let gmtOffSetMilliseconds: Int
    let language: String
    let regularMarketTime: TimeData
    let quoteType: String
    let spark: SparkData
    let regularMarketPrice: PriceData
}

struct TimeData: Decodable {
    let raw: Int
    let fmt: String
}

struct SparkData: Decodable {
    let timestamp: [Int]
    let symbol: String
    let end: Int?
    let previousClose: Double
    let chartPreviousClose: Double
    let close: [Double?]?
    let start: Int?
    let dataGranularity: Int
}

struct PriceData: Decodable {
    let raw: Double
    let fmt: String
}
