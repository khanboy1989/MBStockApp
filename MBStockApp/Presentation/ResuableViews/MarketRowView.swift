//
//  MarketRowView.swift
//  MBStockApp
//
//  Created by Serhan Khan on 30/05/2025.
//

import SwiftUI

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
