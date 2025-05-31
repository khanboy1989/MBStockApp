//
//  Double+String.swift
//  MBStockApp
//
//  Created by Serhan Khan on 31/05/2025.
//

import Foundation

extension Double {
    /// Formats the double to a string with a specified number of decimal places.
    ///
    /// - Parameter decimals: The number of digits after the decimal point (default is 2).
    /// - Returns: A string representation of the number with the given precision.
    func formatted(decimals: Int = 2) -> String {
        String(format: "%.\(decimals)f", self)
    }

    /// Converts a large number into an abbreviated string format.
    ///
    /// Examples:
    /// - 1,500 → "1.50K"
    /// - 2,300,000 → "2.30M"
    /// - 1,200,000,000 → "1.20B"
    ///
    /// - Returns: A human-readable abbreviation for large numbers.
    func abbreviatedString() -> String {
        let num = abs(self) // Ensures we're working with a positive number for formatting

        switch num {
        case 1_000_000_000...:
            // Number is in billions
            return String(format: "%.2fB", self / 1_000_000_000)
        case 1_000_000...:
            // Number is in millions
            return String(format: "%.2fM", self / 1_000_000)
        case 1_000...:
            // Number is in thousands
            return String(format: "%.2fK", self / 1_000)
        default:
            // Number is below 1,000, just format normally
            return self.formatted()
        }
    }
}
