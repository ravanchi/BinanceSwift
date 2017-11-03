//
//  Depth.swift
//  BinanceSwift
//
//  Created by Ali Ravanchi on 11/3/17.
//  Copyright © 2017 Cardinal Labs. All rights reserved.
//

import Foundation

class Depth {
    public private(set) var lastUpdateId: Int = 0
    public private(set) var symbol: String = ""
    public private(set) var bids: [Double: Double] = [:]
    public private(set) var asks: [Double: Double] = [:]

    convenience init(lastUpdateId: Int, symbol: String, bids: [Double: Double], asks: [Double: Double]) {
        self.init()
        self.lastUpdateId = lastUpdateId
        self.symbol = symbol
        self.bids = bids
        self.asks = asks
    }
}
