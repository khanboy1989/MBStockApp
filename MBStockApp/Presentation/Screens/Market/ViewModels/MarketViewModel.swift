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
    
    @Published var summaries: [MarketSummary] = []
    
    // MARK: - Init -
    init(getMarketSummaryUseCase: any GetMarketSummaryUC) {
        self.getMarketSummaryUseCase = getMarketSummaryUseCase
    }
}

extension MarketViewModel {
    func fetchMarketSummary() async {
        self.state = .loading
        let result = await getMarketSummaryUseCase.execute()
        switch result {
        case let .success(summaries):
            self.state = .success
            self.summaries = summaries
        case let .failure(error):
            self.state = .error(error.localizedDescription)
        }
    }
}
