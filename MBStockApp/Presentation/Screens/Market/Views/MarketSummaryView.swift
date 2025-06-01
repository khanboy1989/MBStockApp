//
//  MarketView.swift
//  MBStockApp
//
//  Created by Serhan Khan on 30/05/2025.
//

import SwiftUI

// MARK: - Main View
struct MarketSummaryView: View {
    @StateObject private var viewModel = Resolver.shared.resolve(MarketSummaryViewModel.self)
    @EnvironmentObject private var router: Router
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            ZStack {
                Color.black.ignoresSafeArea()
                BaseStateView(viewModel: viewModel) {
                    content
                } loadingView: {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(1.5)
                        .tint(.white)
                } refreshingView: {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(1.0)
                        .tint(.white)
                }
            }
            .searchable(text: $viewModel.searchText)
            .navigationTitle("stockMarket".localized())
            .navigationDestination(for: MarketSummaryViewDestination.self) { destination in
                switch destination {
                case .marketQuoteDetail(let item):
                    MarketQuoteDetailView(region: viewModel.region, symbol: item.id)
                }
            }
        }
        .task {
            await viewModel.fetchMarketSummary(isRefreshing: false)
        }
        .onDisappear {
            self.viewModel.stopAutoRefresh()
        }
    }
    
    var content: some View {
        MarketListView(
            items: viewModel.filteredSummaries,
            itemView: { item in
                MarketRowView(item: item)
            },
            onItemTap: { item in
                router.navigate(to: MarketSummaryViewDestination.marketQuoteDetail(item))
            }
        )
        .background(Color.black)
    }
}
