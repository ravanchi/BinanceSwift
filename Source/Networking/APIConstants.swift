//
//  APIConstants.swift
//  BinanceSwift
//
//  Created by Ali Ravanchi on 11/2/17.
//  Copyright © 2017 Cardinal Labs. All rights reserved.
//

enum Endpoint: String {
    case ping = "v1/ping"
    case time = "v1/time"
    case allPrices = "v1/ticker/allPrices"
    case depth = "v1/depth"
    case account = "v3/account"
    case openOrders = "v3/openOrders"

    func isSigned() -> Bool {
        switch self {
        case .account, .openOrders:
            return true
        default:
            return false
        }
    }
}

struct APIConstants {
    static let baseURL = "https://www.binance.com/api/"

    static let serverTime = "serverTime"
    static let symbol = "symbol"
    static let price = "price"
    static let limit = "limit"
    static let lastUpdateId = "lastUpdateId"
    static let bids = "bids"
    static let asks = "asks"
    static let apiKey = "apiKey"
    static let secret = "secret"
    static let headerApiKey = "X-MBX-APIKEY"
    static let signature = "signature"
}
