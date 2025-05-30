//
//  MarketSummaryModel+DomainMapper.swift
//  MBStockApp
//
//  Created by Serhan Khan on 30/05/2025.
//

extension MarketResult: DomainMapper {
    func toDomain() -> MarketSummary {
        .init(fullExchangeName: fullExchangeName, symbol: symbol)
    }
}
