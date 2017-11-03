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
}

struct APIConstants {
    static let baseURL = "https://www.binance.com/api/v1/"

    static let serverTime = "serverTime"
}
