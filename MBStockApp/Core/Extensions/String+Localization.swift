//
//  String+Localization.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//
import Foundation

extension String {
    /// Localizes the string using the `Localizable.strings` file.
    func localized(with comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
