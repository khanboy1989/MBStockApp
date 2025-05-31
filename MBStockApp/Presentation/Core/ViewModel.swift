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
    
    /// Handles Specific API returned AppError (converted from Network Error)
    /// - SeeAlso: NetworkError Enum
    func extractNetworkErrorMessage(from error: Error) -> String {
        if let error = error as? AppError {
            switch error {
            case let .networkError(message):
                return message
            case let .emptyDataError(message):
                return message
            default:
                return error.localizedDescription
            }
        } else {
            return error.localizedDescription
        }
    }
}

enum ViewState: Equatable {
    case initial
    case loading
    case error(String)
    case success
    case empty
    case refreshing
}
