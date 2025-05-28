//
//  RequestProtocol.swift
//  MBStockApp
//
//  Created by Serhan Khan on 28/05/2025.
//

import Foundation
import OSLog

protocol RequestProtocol {
    var path: String { get }
    var requestType: RequestType { get }
    var headers: [String: String] { get }
    var params: [String: Any] { get }
    var urlParams: [String: String?] { get }
}

