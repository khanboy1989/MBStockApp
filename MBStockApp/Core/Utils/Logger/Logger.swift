//
//  Logger.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//

import Foundation
import OSLog

extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "MBStockApp"
    static let networking = Logger(subsystem: subsystem, category: "networking")
    static let parserError = Logger(subsystem: subsystem, category: "parsing")
}
