//
//  MarketRequest.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//

import Foundation

enum MarketsRequest: RequestProtocol {
    case summary(region: String)
    
    var path: String {
        switch self {
        case .summary:
            return "/market/" + ApiConstants.apiVersion + "/get-summary"
        }
    }
    
    var urlParams: [String: String?] {
        switch self {
        case let .summary(region):
            return ["region": region]
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .summary:
            return .GET
        }
    }
}
