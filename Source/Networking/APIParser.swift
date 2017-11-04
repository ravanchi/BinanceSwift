//
//  APIParser.swift
//  BinanceSwift
//
//  Created by Ali Ravanchi on 11/3/17.
//  Copyright © 2017 Cardinal Labs. All rights reserved.
//

import Foundation

class APIParser {
    // MARK: General endpoint parsers

    static func parseServerTime(json: Any) -> Int? {
        guard let serverTimeJSON = json as? [String: Any] else { return nil }

        return serverTimeJSON[APIConstants.serverTime] as? Int
    }

    static func parseAllPrices(json: Any) -> [String: Double]? {
        guard let symbols = json as? [Dictionary<String, Any>] else { return nil }

        var prices = [String: Double]()

        for symbolData in symbols {
            if let symbol = symbolData[APIConstants.symbol] as? String, let price = symbolData[APIConstants.price] as? String {
                prices[symbol] = Double(price)
            }
        }

        if prices.count != 0 {
            return prices
        } else {
            return nil
        }
    }

    // MARK: Market endpoint parsers

    static func parseSymbolDepth(symbol: String, json: Any) -> Depth? {
        guard let depthJSON = json as? [String: Any],
            let lastUpdateId = depthJSON[APIConstants.lastUpdateId] as? Int,
            let bidsJSON = depthJSON[APIConstants.bids] as? [Any],
            let asksJSON = depthJSON[APIConstants.asks] as? [Any] else {
                return nil
        }

        // Need to do some special filtering since this json structure is weird and has an empty array in the bid array
        let bids = filterDepthData(with: bidsJSON)
        let asks = filterDepthData(with: asksJSON)

        return Depth(lastUpdateId: lastUpdateId, symbol: symbol, bids: bids, asks: asks)
    }

    // MARK: Account endpoint parsers

    static func parseAccountInformation(json: Any) -> Account? {
        return nil
    }
}

extension Helpers {
    private static func filterDepthData(with dataArray: [Any]) -> [Double: Double] {
        var data = [Double: Double]()

        for unfilteredData in dataArray {
            let filteredData = (unfilteredData as? [Any])?.filter({($0 as? [Any]) == nil}) as? [String]
            if let filteredData = filteredData, let price = Double(filteredData[0]), let quantity = Double(filteredData[1]) {
                data[price] = quantity
            }
        }

        return data
    }
}

private typealias Helpers = APIParser
