//
//  AppError.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//
import Foundation

enum AppError: Error, Equatable {
    case networkError(String)
    case parsingError(String)
    case serverError(String)
    case unknownError(String)
    case localDataFetchError(String)
}
