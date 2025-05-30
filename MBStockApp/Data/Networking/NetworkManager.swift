//
//  NetworkManager.swift
//  MBStockApp
//
//  Created by Serhan Khan on 28/05/2025.
//

import Foundation
import OSLog

/// The network manager protocol
/// It is responsible for making network requets
protocol NetworkManager {
    func makeRequest(with requestData: RequestProtocol) async throws -> Data
}

/// Default Network Manager implements NetworkManager protocol methods & params
final class DefaultNetworkManager: NetworkManager {
    /// URLSession instance
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    //// Makes a network request.
    ///
    /// - Parameter requestData: The request data
    /// - Returns: The response data
    /// - Throws: An error if the request fails.
    /// - Note: This method is asynchronous.
    /// - Important: The request data should conform to `RequestProtocol`.
    /// - SeeAlso: `RequestProtocol`
    func makeRequest(with requestData: RequestProtocol) async throws -> Data {
        let request = try requestData.request()
        var responseStatusCode: Int?
        
        do {
            let (data, response) = try await urlSession.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidServerResponse("Invalid response from server.")
            }

            responseStatusCode = httpResponse.statusCode

            if !(200...299).contains(httpResponse.statusCode) {
                // Try to decode the error message from server
                if let errorMessage = try? JSONDecoder().decode([String: String].self, from: data),
                   let message = errorMessage["message"] {
                    throw NetworkError.invalidServerResponse(message)
                } else {
                    throw NetworkError.invalidServerResponse("Server returned status code \(httpResponse.statusCode)")
                }
            }

            logSuccess(request)
            return data
        } catch {
            logError(responseStatusCode, request, error)
            throw error
        }
    }
    
    private func logSuccess(_ request: URLRequest) {
        Logger.networking.info("""
            ✅ [200] [\(request.httpMethod ?? "")] \
            \(request, privacy: .private)
        """)
    }

    private func logError(_ responseStatusCode: Int?, _ request: URLRequest, _ error: Error) {
        Logger.networking.error("""
            🛑 [Error] [\(responseStatusCode ?? 0)] [\(request.httpMethod ?? "")] \
            \(request, privacy: .private)
            🔍 Error: \(error.localizedDescription)
        """)
        
        Logger.networking.error("""
                    \(self.curlString(from: request))
                    """)
    }
    
    private func curlString(from request: URLRequest) -> String {
        guard let url = request.url else { return "# Invalid URL" }

        var components: [String] = ["curl"]

        // Method
        if let method = request.httpMethod {
            components.append("--request \(method)")
        }

        // Headers
        if let headers = request.allHTTPHeaderFields {
            for (key, value) in headers {
                components.append("--header '\(key): \(value)'")
            }
        }

        // Body
        if let bodyData = request.httpBody,
           let bodyString = String(data: bodyData, encoding: .utf8) {
            components.append("--data '\(bodyString)'")
        }

        // URL
        components.append("'\(url.absoluteString)'")

        return components.joined(separator: " \\\n  ")
    }
}
