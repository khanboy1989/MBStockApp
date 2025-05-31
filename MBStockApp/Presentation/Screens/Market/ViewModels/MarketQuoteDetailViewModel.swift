//
//  MarketQuoteDetailViewModel.swift
//  MBStockApp
//
//  Created by Serhan Khan on 31/05/2025.
//

import SwiftUI

final class MarketQuoteDetailViewModel: ViewModel {
    // MARK: - Dependecies -
    private let getMarketQuoteUC: GetMarketQuoteUC
    
    // MARK: - Properties
    @Published var marketQuote: MarketQuote?
    
    // MARK: - Init -
    init(getMarketQuoteUC: any GetMarketQuoteUC) {
        self.getMarketQuoteUC = getMarketQuoteUC
    }
}

extension MarketQuoteDetailViewModel {
    
    // MARK: - Use Case Network Calls
    func getMarketQuote(region: String, symbol: String) async {
        self.state = .loading
        let result = await self.getMarketQuoteUC.execute(region, symbol: symbol)
        switch result {
        case let .success(marketQuote):
            self.state = .success
            self.marketQuote = marketQuote
        case let .failure(error):
            self.state = .error(extractNetworkErrorMessage(from: error))
        }
    }
}
