//
//  BinanceClientInterface.swift
//  BinanceSwift
//
//  Created by Ali Ravanchi on 11/3/17.
//  Copyright © 2017 Cardinal Labs. All rights reserved.
//

import Foundation

/**
 General endpoints interface
 */
protocol GeneralClientInterface {
    /**
     Test connectivity to the Rest API.
     - parameter completion: If no error was encountered, a successful ping was made to the API server
     */
    func ping(completion: @escaping PingCompletion)

    /**
     Test connectivity to the Rest API and get the current server time.
     - parameter completion: If no error was encountered, returns back an Int representing the time in epoch
     */
    func getServerTime(completion: @escaping ServerTimeCompletion)
}

/**
 Market endpoints interface
 */
protocol MarketClientInterface {
    /**
     Latest price for all symbols.
     - parameter completion: If no error was encountered, returns back a dictionary mapping symbol -> price for all symbols returned
     */
    func getAllPrices(completion: @escaping allPricesCompletion)

    /**
     Latest price for a specific symbol.
     - parameter symbol: The currency symbol we want the price for (i.e LTCBTC)
     - parameter completion: If no error was encountered, returns back a double representing the price for the symbol
     */
    func getPrice(for symbol: String, completion: @escaping symbolPriceCompletion)

    /**
     Get order book (depth) of a specific symbol
     - parameter symbol: The currency symbol we want the depth for (i.e LTCBTC)
     - parameter limit: # of results we want for each bids and asks. Default/Max is 100
     - parameter completion: If no error was encountered, returns back a Depth object
     */
    func getDepth(for symbol: String, limit: Int?, completion: @escaping depthCompletion)
}

/**
 Account endpoints interface
 */
protocol AccountClientInterface {

}
