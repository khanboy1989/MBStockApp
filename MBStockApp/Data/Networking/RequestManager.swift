//
//  RequestManager.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//

import Foundation

// MARK: - Request manager protocol
protocol RequestManager {
    var networkManager: NetworkManager { get }
    var parser: DataParser { get }
    func makeRequest<T: Decodable>(with requestData: RequestProtocol) async throws -> T
}

// MARK: - Default Request Manager
final class DefaultRequestManager: RequestManager {
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
    }
    
    /// Makes a network request
    ///
    /// - Parameters: requestData: The request data to be sent
    /// - Returns: The response data decoded to the specified type.
    /// - Throws: An error if the request fails
    /// - Note: This method is asynchronous
    /// - Important: The request data should conform to `Request Protocol`
    /// - SeeAlso: `RequestProtocol`
    /// - SeeAlso: `NetworkError`
    func makeRequest<T: Decodable>(with requestData: RequestProtocol) async throws -> T {
        let data = try await networkManager.makeRequest(with: requestData)
        let decoded: T = try parser.parse(data: data)
        return decoded
    }
}

// MARK: - Returns Data Parser

extension RequestManager {
    var parser: DataParser {
        return DefaultDataParser()
    }
}
