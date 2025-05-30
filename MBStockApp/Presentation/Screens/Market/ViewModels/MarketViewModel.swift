//
//  MarketViewModel.swift
//  MBStockApp
//
//  Created by Serhan Khan on 30/05/2025.
//

// MARK: - ViewModel -
import Foundation
import Combine

@MainActor
final class MarketViewModel: ViewModel {
    
    // MARK: - Dependecies -
    private let getMarketSummaryUseCase: any GetMarketSummaryUC
    private let region: String = "US"
    private var cancellables = Set<AnyCancellable>()
    
    @Published var summaries: [MarketSummary] = []
    
    // MARK: - Init -
    init(getMarketSummaryUseCase: any GetMarketSummaryUC) {
        self.getMarketSummaryUseCase = getMarketSummaryUseCase
        super.init()
        self.startAutoRefresh()
    }
}

// MARK: - Extensions -
extension MarketViewModel {
    
    // MARK: - Refresh Loop
    private func startAutoRefresh() {
        Timer
            .publish(every: ApiConstants.refreshRate, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                Task {
                    await self?.fetchMarketSummary(isRefreshing: true)
                }
            }
            .store(in: &cancellables)
    }
    
    func stopAutoRefresh() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    func fetchMarketSummary(isRefreshing: Bool) async {
        self.state = isRefreshing ? .refreshing : .loading
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
