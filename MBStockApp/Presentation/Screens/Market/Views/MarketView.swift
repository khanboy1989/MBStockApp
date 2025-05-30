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
                        .searchable(text: $searchText)
                } loadingView: {
                    ProgressView()
                        .tint(.white)
                }
            }
            .navigationTitle("stockMarket".localized())
        }
        .task {
            await viewModel.fetchMarketSummary()
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
// MARK: - Row View
struct MarketRowView: View {
    let item: MarketSummary
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                Text(item.id)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(String(format: "%.2f", item.price))
                    .font(.subheadline)

                Text(String(format: "%.2f%%", item.changePercent))
                    .font(.subheadline)
                    .foregroundColor(item.changePercent >= 0 ? .green : .red)
            }
        }
        .padding()
        .background(Color(.darkGray))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
