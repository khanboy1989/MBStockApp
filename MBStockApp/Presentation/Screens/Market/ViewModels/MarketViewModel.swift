//
//  MarketViewModel.swift
//  MBStockApp
//
//  Created by Serhan Khan on 30/05/2025.
//

// MARK: - ViewModel -
import Foundation

@MainActor
final class MarketViewModel: ViewModel {
    
    // MARK: - Dependecies -
    private let getMarketSummaryUseCase: any GetMarketSummaryUC
    private let region: String = "US"
    @Published var summaries: [MarketSummary] = []
    
    // MARK: - Init -
    init(getMarketSummaryUseCase: any GetMarketSummaryUC) {
        self.getMarketSummaryUseCase = getMarketSummaryUseCase
    }
}

// MARK: - Extensions - 
extension MarketViewModel {
    func fetchMarketSummary() async {
        self.state = .loading
        let result = await getMarketSummaryUseCase.execute(region)
        switch result {
        case let .success(summaries):
            self.state = .success
            self.summaries = summaries
        case let .failure(error):
            self.state = .error(extractNetworkErrorMessage(from: error))
        }
    }
}
