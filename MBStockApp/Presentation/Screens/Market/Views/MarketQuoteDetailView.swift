//
//  MarketQuoteDetailView.swift
//  MBStockApp
//
//  Created by Serhan Khan on 31/05/2025.
//

import SwiftUI

struct MarketQuoteDetailView: View {
    // MARK: - Properties
    @StateObject private var viewModel = Resolver.shared.resolve(MarketQuoteDetailViewModel.self)
    private let region: String
    private let symbol: String
    
    // MARK: - Init -
    init(region: String, symbol: String) {
        self.region = region
        self.symbol = symbol
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            BaseStateView(viewModel: viewModel) {
                if let quote = viewModel.marketQuote {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            header(quote)
                            Divider().background(.white.opacity(0.2))
                            metrics(quote)
                            Divider().background(.white.opacity(0.2))
                            priceRange(quote)
                        }
                        .padding()
                    }
                }
            }
            loadingView: {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(1.5)
                    .tint(.white)
            }
        }
        .task {
            await viewModel.getMarketQuote(region: region, symbol: symbol)
        }
    }
    
    // MARK: - Header -
    private func header(_ quote: MarketQuote) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(quote.shortName) (\(quote.symbol))")
                .font(.title2.bold())
                .foregroundColor(.white)
            
            HStack(spacing: 8) {
                Text("\(quote.currency ?? "") \(quote.price.formatted(.number.precision(.fractionLength(2))))")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                Text("(\(quote.changePercent, specifier: "%.2f")%)")
                    .foregroundColor(quote.changePercent >= 0 ? .green : .red)
                    .font(.headline)
            }
        }
    }
    
    // MARK: - Metrics -
    private func metrics(_ quote: MarketQuote) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            metricRow("marketCap".localized(), quote.marketCap?.abbreviatedString() ?? "-")
            metricRow("volume".localized(), quote.volume?.formatted() ?? "-")
            metricRow("peRation".localized(), quote.peRatio?.formatted() ?? "-")
            metricRow("eps".localized(), quote.eps?.formatted() ?? "-")
            metricRow("open".localized(), quote.open?.formatted() ?? "-")
            metricRow("high".localized(), quote.dayHigh?.formatted() ?? "-")
            metricRow("low".localized(), quote.dayLow?.formatted() ?? "-")
        }
    }
    
    // MARK: - 52 Week Range -
    private func priceRange(_ quote: MarketQuote) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("fiftyTwoWeekRange".localized())
                .font(.headline)
                .foregroundColor(.white)
            
            let low = quote.fiftyTwoWeekLow ?? 0
            let high = quote.fiftyTwoWeekHigh ?? 1
            let current = quote.price
            let progress = CGFloat((current - low) / (high - low))
            
            VStack(alignment: .leading) {
                HStack {
                    Text(low.formatted())
                    Spacer()
                    Text(high.formatted())
                }
                .foregroundColor(.gray)
                
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule().fill(Color.gray.opacity(0.3)).frame(height: 8)
                        Capsule().fill(.blue).frame(width: geo.size.width * progress, height: 8)
                    }
                }
                .frame(height: 8)
            }
        }
    }
}


// MARK: - Extensions -
extension MarketQuoteDetailView {
    // MARK: - Helper -
    private func metricRow(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .foregroundColor(.white)
        }
        .font(.subheadline)
    }
}
