//
//  MarketRequest.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//

import Foundation

enum MarketsRequest: RequestProtocol {
    case summary(region: String)
    case quotes(region: String, symbol: String)
    var path: String {
        switch self {
        case .summary:
            return "/market/" + ApiConstants.apiVersion + "/get-summary"
        case .quotes:
            return "/market/" + ApiConstants.apiVersion + "/get-quotes"
        }
    }
    
    var urlParams: [String: String?] {
        switch self {
        case let .summary(region):
            return ["region": region]
        case let .quotes(region, symbol):
            return ["region": region, "symbols": symbol]
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .summary:
            return .GET
        case .quotes:
            return .GET
        }
    }
}
