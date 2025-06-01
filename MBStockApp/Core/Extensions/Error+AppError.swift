//
//  Error+AppError.swift
//  MBStockApp
//
//  Created by Serhan Khan on 30/05/2025.
//

import Foundation

extension Error {
    /// Converts any `NetworkError`  to an `AppError` object.
    var toAppError: AppError {
        if let error = self as? NetworkError {
            switch error {
            case .invalidURL:
                return .networkError(error.errorDescription)
            case let .invalidServerResponse(message):
                return .networkError(message)
            }
        }
        return AppError.unknownError("unknownError")
    }
}
