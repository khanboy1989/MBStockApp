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
    @State private var searchText: String = ""
    var body: some View {
        NavigationView {
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
            }.searchable(text: $searchText)
            .navigationTitle("stockMarket".localized())
        }
        .task {
            await viewModel.fetchMarketSummary(isRefreshing: false)
        }
        .onDisappear {
            self.viewModel.stopAutoRefresh()
        }
    }
    
    var content: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.summaries, id: \.id) { item in
                    MarketRowView(item: item)
                        .padding(.horizontal)
                }
            }
            .padding(.top)
        }
        .background(Color.black)
    }
}
