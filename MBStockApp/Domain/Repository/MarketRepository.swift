//
//  MarketRepository.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//

import Foundation

/// MarketRepository
/// Holds the market related endpoint calls' blueprints
protocol MarketRepository {
    func getMarketSummary(region: String) async -> Result<[MarketSummary], AppError>
    
    func getMarketQuote(region: String, symbol: String) async -> Result<MarketQuote, AppError>
}
