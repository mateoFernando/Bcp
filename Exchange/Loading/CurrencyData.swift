//
//  CurrencyData.swift
//  Exchange
//
//  Created by Fernando Daniel on 7/04/22.
//

import Foundation

struct CurrencyData: Codable {
    let currencies: [Country]
}

struct Country: Codable {
    let country: String
    let id: String
    let title: String
    let ratesBuy: [String:Double]
    let ratesSell: [String:Double]
    var type: TypeSelected?

    mutating func updateType(_ type: TypeSelected) {
        self.type = type
    }
}

struct Rate: Codable {
    let EURO: Double
    let USD: Double
    let YEN: Double
    let POUND: Double
    let FRANC: Double
    let CD: Double
    let SOL: Double
}

enum TypeSelected: Codable {
    case send
    case recieve
    case none
}
