//
//  DataParser.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//

import Foundation
import os.log

protocol DataParser {
    func parse<T: Decodable>(data: Data) throws -> T
}

/// Parsing Data to Given Model Type
final class DefaultDataParser: DataParser {
    private var jsonDecoder: JSONDecoder

    init(jsonDecoder: JSONDecoder = .init()) {
        self.jsonDecoder = jsonDecoder
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func parse<T: Decodable>(data: Data) throws -> T {
        do {
            return try jsonDecoder.decode(T.self, from: data)
        } catch let decodingError as DecodingError {
            logDecodingError(decodingError, type: T.self, data: data)
            throw decodingError
        } catch {
            Logger.parserError.error("❌ Unknown parsing error: \(error.localizedDescription)")
            throw error
        }
    }

    private func logDecodingError<T>(_ error: DecodingError, type: T.Type, data: Data) {
        var message = "🧨 Decoding error while decoding \(type):\n"

        switch error {
        case .keyNotFound(let key, let context):
            message += """
            🔑 Missing key: "\(key.stringValue)"
            Context: \(context.debugDescription)
            CodingPath: \(context.codingPath.map(\.stringValue).joined(separator: " ➜ "))
            """

        case .typeMismatch(let expectedType, let context):
            message += """
            🚫 Type mismatch for type: \(expectedType)
            Context: \(context.debugDescription)
            CodingPath: \(context.codingPath.map(\.stringValue).joined(separator: " ➜ "))
            """

        case .valueNotFound(let valueType, let context):
            message += """
            📭 Value not found for type: \(valueType)
            Context: \(context.debugDescription)
            CodingPath: \(context.codingPath.map(\.stringValue).joined(separator: " ➜ "))
            """

        case .dataCorrupted(let context):
            message += """
            🧩 Data corrupted.
            Context: \(context.debugDescription)
            CodingPath: \(context.codingPath.map(\.stringValue).joined(separator: " ➜ "))
            """
        @unknown default:
            message += "⚠️ Unknown decoding error"
        }

        Logger.parserError.error("\(message, privacy: .private)")
    }
}
