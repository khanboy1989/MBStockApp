//
//  MarketView.swift
//  MBStockApp
//
//  Created by Serhan Khan on 30/05/2025.
//

import SwiftUI

struct MarketView: View {
    @StateObject private var viewModel = Resolver.shared.resolve(MarketViewModel.self)
    
    var body: some View {
        NavigationView {
            ZStack {
                BaseStateView(viewModel: viewModel) {
                  content
                }
            }
        }
    }
    
    var content: some View {
        LazyVStack {
            ForEach(viewModel.summaries, id: \.fullExchangeName) { item in
                Text(item.fullExchangeName)
            }
        }.task {
            await viewModel.fetchMarketSummary()
        }
    }
}
