//
//  MarketListView.swift
//  MBStockApp
//
//  Created by Serhan Khan on 30/05/2025.
//

import SwiftUI

/// Generic MarketListView We pass the Item and ItemView it would be represented
/// on the parent
struct MarketListView<Items, ItemView>: View where Items: Identifiable, Items: Equatable, ItemView: View {
    
    // MARK: - Properties -
    let items: [Items]
    let itemView: (Items) -> ItemView
    let onItemTap: ((Items) -> Void)?
    
    // MARK: - Init -
    init(items: [Items],
         @ViewBuilder itemView: @escaping (Items) -> ItemView,
         onItemTap: ((Items) -> Void)? = nil) {
        self.items = items
        self.itemView = itemView
        self.onItemTap = onItemTap
    }
    
    // MARK: - Body -
    var body: some View {
        List {
            ForEach(items) { item in
                ZStack(
                    content: {
                        itemView(item)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                self.onItemTap?(item)
                            }
                    }
                )//: ZStack
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            }//: ForEach
        }//: List
        .listStyle(PlainListStyle())
        .scrollIndicators(.hidden)
        .background(.black)
    }
}
