//
//  MarketSummaryViewModel.swift
//  MBStockApp
//
//  Created by Serhan Khan on 30/05/2025.
//

import Foundation
import Combine

@MainActor
final class MarketSummaryViewModel: ViewModel {
    
    // MARK: - Dependencies -
    private let getMarketSummaryUseCase: any GetMarketSummaryUC
    let region: String = "US"

    // MARK: - Published Properties -
    @Published var summaries: [MarketSummary] = []
    @Published var filteredSummaries: [MarketSummary] = []
    @Published var searchText: String = ""
    @Published var isRefreshing: Bool = false

    var cancellables = Set<AnyCancellable>()

    // MARK: - Init -
    init(getMarketSummaryUseCase: any GetMarketSummaryUC) {
        self.getMarketSummaryUseCase = getMarketSummaryUseCase
        super.init()
        addSubscribers()
        startAutoRefresh()
    }

    // MARK: - Search Filtering -
    private func addSubscribers() {
        $searchText
            .removeDuplicates()
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.filterSummaries(by: text)
            }
            .store(in: &cancellables)
    }
}

extension MarketSummaryViewModel {
    
    // MARK: - Network Calls-
    // MARK: - Fetch Market Summary -
    func fetchMarketSummary(isRefreshing: Bool) async {
        self.state = isRefreshing ? .refreshing : .loading
        let result = await getMarketSummaryUseCase.execute(region)
        switch result {
        case let .success(summaries):
            self.state = .success
            self.summaries = summaries
            self.filterSummaries(by: self.searchText) // re-filter with current text
        case let .failure(error):
            self.state = .error(extractNetworkErrorMessage(from: error))
        }
    }
    
    // MARK: - Timer for refresher -
    // MARK: - Auto Refresh Every 8 Seconds -
    func startAutoRefresh() {
        Timer.publish(every: 8, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                Task { await self?.fetchMarketSummary(isRefreshing: true) }
            }
            .store(in: &cancellables)
    }

    // MARK: - Stops the cancellables for each added timer
    // When View Dissapears
    func stopAutoRefresh() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

extension MarketSummaryViewModel {
    
    // MARK: - Applying Filtering with searchText
    private func filterSummaries(by text: String) {
        guard !text.isEmpty else {
            filteredSummaries = summaries
            return
        }

        filteredSummaries = summaries.filter {
            $0.name.localizedCaseInsensitiveContains(text) 
        }
    }
}
