//
//  MarketSummary.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//

import Foundation

/// Market Summary model for ViewModel representation
/// It is one more layer in order to transfer necessary data from Network Call to View
struct MarketSummary: Identifiable, Equatable, Hashable {
    let id: String            // symbol
    let name: String          // fullExchangeName
    let price: Double         // regularMarketPrice.raw
    let previousClose: Double // spark.previousClose

    /// Computes the % change between current price and previous close
    var changePercent: Double {
        guard previousClose != 0 else { return 0 }
        return ((price - previousClose) / previousClose) * 100
    }
}
