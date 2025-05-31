//
//  DomainMapper.swift
//  MBStockApp
//
//  Created by Serhan Khan on 30/05/2025.
//

import Foundation

// Mapper from Domain To Entity
// In order to pass the necessary values to UI
protocol DomainMapper {
    associatedtype EntityType
    func toDomain() -> EntityType
}
