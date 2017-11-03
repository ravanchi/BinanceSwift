//
//  APIConstants.swift
//  BinanceSwift
//
//  Created by Ali Ravanchi on 11/2/17.
//  Copyright © 2017 Cardinal Labs. All rights reserved.
//

enum Endpoint: String {
    case ping = "ping"
    case time = "time"
    case allPrices = "ticker/allPrices"
    case depth = "depth"
}

struct APIConstants {
    static let baseURL = "https://www.binance.com/api/v1/"

    static let serverTime = "serverTime"
    static let symbol = "symbol"
    static let price = "price"
    static let limit = "limit"
    static let lastUpdateId = "lastUpdateId"
    static let bids = "bids"
    static let asks = "asks"
}
