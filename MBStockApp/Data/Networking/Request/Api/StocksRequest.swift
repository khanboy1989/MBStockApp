//
//  StocksRequest.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//

import Foundation

enum StocksRequest: RequestProtocol {
    case summary(symbol: String, region: String)
    
    var path: String {
        switch self {
        case .summary:
            return "stock/" + ApiConstants.apiVersion + "/get-summary"
        }
    }
    
    var urlParams: [String: String?] {
        switch self {
        case let .summary(symbol, region):
            return ["symbol": symbol, "region": region]
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .summary:
            return .GET
        }
    }
    
}
