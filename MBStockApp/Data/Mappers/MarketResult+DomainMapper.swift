//
//  MarketSummaryModel+DomainMapper.swift
//  MBStockApp
//
//  Created by Serhan Khan on 30/05/2025.
//

import Foundation

extension MarketResult: DomainMapper {
    func toDomain() -> MarketSummary {
        return MarketSummary(
            id: symbol,
            name: fullExchangeName,
            price: regularMarketPrice.raw,
            previousClose: spark.previousClose
        )
    }
}
