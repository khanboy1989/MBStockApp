//
//  ViewModel.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//
import Foundation

@MainActor
class ViewModel: ObservableObject {
    @Published var state: ViewState = .initial
}

enum ViewState: Equatable {
    case initial
    case loading
    case error(String)
    case success
    case empty
}
