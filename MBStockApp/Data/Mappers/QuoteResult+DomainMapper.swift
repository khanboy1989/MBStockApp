//
//  QuoteResponse+DomainMapper.swift
//  MBStockApp
//
//  Created by Serhan Khan on 31/05/2025.
//

extension QuoteResult: DomainMapper {
    func toDomain() -> MarketQuote {
        MarketQuote(
            symbol: symbol ?? "-",                            // Symbol fallback
            shortName: shortName ?? longName ?? "N/A",       // Prefer shortName, fallback to longName
            price: regularMarketPrice ?? 0,                  // Show price or default to 0
            changePercent: regularMarketChangePercent ?? 0,  // Percent change for visual indicator
            currency: currency,                              // Optional – used in UI if not always USD
            marketCap: marketCap,                            // Shown in detail/summary
            volume: regularMarketVolume,                     // Used in analytics & detail view
            peRatio: trailingPE,                             // Valuation metric
            eps: epsTrailingTwelveMonths,                    // Shown in company fundamentals
            open: regularMarketOpen,                         // Today’s open price
            dayHigh: regularMarketDayHigh,                   // Daily high (range display)
            dayLow: regularMarketDayLow,                     // Daily low (range display)
            fiftyTwoWeekHigh: fiftyTwoWeekHigh,              // For 52-week performance bar
            fiftyTwoWeekLow: fiftyTwoWeekLow                 // For 52-week performance bar
        )
    }
}
