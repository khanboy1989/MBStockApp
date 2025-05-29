//
//  BaseResponse.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//

struct BaseResponse<T> {
    let code: Int
    let status: String
    let data: T
}
