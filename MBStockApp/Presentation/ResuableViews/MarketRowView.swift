//
//  MarketRowView.swift
//  MBStockApp
//
//  Created by Serhan Khan on 30/05/2025.
//

import SwiftUI

// MARK: - Row View -
// A reusable SwiftUI view to display a single market summary item.
struct MarketRowView: View {
    // The data model for one market item
    let item: MarketSummary

    var body: some View {
        HStack {
            // Left-aligned VStack: displays the item name and ID
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name) // Display the market name (e.g., Apple Inc.)
                    .font(.headline)

                Text(item.id) // Display the market symbol or identifier (e.g., AAPL)
                    .font(.caption)
                    .foregroundColor(.gray) // Use gray to visually separate it from name
            }

            Spacer() // Push right VStack to the far end of the row

            // Right-aligned VStack: shows price and percentage change
            VStack(alignment: .trailing, spacing: 4) {
                // Format the price to 2 decimal places
                Text(String(format: "%.2f", item.price))
                    .font(.subheadline)

                // Format the change percent and color it green if positive, red if negative
                Text(String(format: "%.2f%%", item.changePercent))
                    .font(.subheadline)
                    .foregroundColor(item.changePercent >= 0 ? .green : .red)
            }
        }
        .padding() // Add internal spacing around content
        .background(Color(.darkGray)) // Set dark gray background color
        .cornerRadius(12) // Round the corners of the row card
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2) // Subtle shadow
    }
}
