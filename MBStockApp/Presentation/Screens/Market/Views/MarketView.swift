//
//  MarketView.swift
//  MBStockApp
//
//  Created by Serhan Khan on 30/05/2025.
//

import SwiftUI

// MARK: - Main View
struct MarketView: View {
    @StateObject private var viewModel = Resolver.shared.resolve(MarketViewModel.self)
    @StateObject private var router = Resolver.shared.resolve(Router.self)
    
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
            .navigationDestination(for: MarketViewDestination.self) { destination in
                switch destination {
                case .stockDetail(let item):
                    MarketDetailView(item: item)
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
                router.navigate(to: MarketViewDestination.stockDetail(item))
            }
        )
        .background(Color.black)
    }
}

struct MarketDetailView: View {
    let item: MarketSummary
    var body: some View {
        VStack(spacing: 16) {
            Text(item.name)
                .font(.largeTitle)
                .foregroundColor(.white)
            Text("Symbol: \(item.id)")
                .foregroundColor(.gray)
            Text(String(format: "Price: %.2f", item.price))
            Text(String(format: "Change: %.2f%%", item.changePercent))
                .foregroundColor(item.changePercent >= 0 ? .green : .red)
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
    }
}
