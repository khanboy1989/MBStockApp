//
//  MarketSummary.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//

import Foundation

struct MarketSummary {
    let fullExchangeName: String
    let symbol: String
}

// ViewModel -> UseCase (Returns Entity) -> Repository (Returns Entity> -> DataSource (Return Model) -> RequestManager
