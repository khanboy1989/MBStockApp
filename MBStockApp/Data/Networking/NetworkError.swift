//
//  NetworkError.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidServerResponse(String)
    case invalidURL
    var errorDescription: String {
        switch self {
        case let .invalidServerResponse(message):
            return message
        case .invalidURL:
            return "URL string is malformed."
        }
    }
}
