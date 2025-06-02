//
//  RequestProtocol.swift
//  MBStockApp
//
//  Created by Serhan Khan on 28/05/2025.
//

import Foundation
import OSLog

// MARK: - RequestProtocol
protocol RequestProtocol {
    var path: String { get } // BaseURL
    var requestType: RequestType { get } // RequestType .GET, .POST
    var headers: [String: String] { get } // Generic header params
    var params: [String: Any] { get } // Params for body and url
    var urlParams: [String: String?] { get }
}

extension RequestProtocol {
    var host: String {
        return ApiConstants.baseURL
    }
    
    var params: [String: Any] {
        return [:]
    }
    
    var urlParams: [String: String?] {
        return [:]
    }
    
    var headers: [String: String] {
        return [
            "x-rapidapi-host": ApiConstants.apiHost,
            "x-rapidapi-key": ApiConstants.apiKey
        ]
    }
    
    // MARK: - Request -
    /// Generates the query with given parameters 
    func request() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        
        Logger.networking.info("🚀 [REQUEST - URL] [\(host)] - [\(path)]")
        
        /// Add default query params
        var queryParamsList: [URLQueryItem] = []

        if !urlParams.isEmpty {
            queryParamsList.append(contentsOf: urlParams.map { URLQueryItem(name: $0, value: $1) })
        }

        components.queryItems = queryParamsList
        
        Logger.networking.debug("🧪 URL Components: \(components)")
        
        guard let url = components.url else {
            Logger.networking.error("URL error: \(String(describing: components.url))")
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue

        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }

        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if !params.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        }
        
        Logger.networking.info("🚀 [REQUEST] [\(requestType.rawValue)] \(urlRequest, privacy: .private) [HEADERS] : [\(headers)]")

        return urlRequest
    }
}
