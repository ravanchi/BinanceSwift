//
//  Depth.swift
//  BinanceSwift
//
//  Created by Ali Ravanchi on 11/3/17.
//  Copyright © 2017 Cardinal Labs. All rights reserved.
//

/**
 Depth represents the order book of a specific symbol. Main data properties are bids and asks. Each one being a dictionary that maps price -> quanitity

 - parameter lastUpdateId: ID of the last updated which will be mainly used for caching purposes
 - parameter symbol: The currency symbol the depth object will represent (i.e LTCBTC)
 - parameter bids: Dictionary that maps price -> quanitity
 - parameter asks: Dictionary that maps price -> quanitity
*/

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
