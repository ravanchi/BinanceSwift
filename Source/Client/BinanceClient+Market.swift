//
//  BinanceClient+Market.swift
//  BinanceSwift
//
//  Created by Ali Ravanchi on 11/2/17.
//  Copyright © 2017 Cardinal Labs. All rights reserved.
//

extension BinanceClient: MarketClientInterface {
    func getAllPrices(completion: @escaping AllPricesCompletion) {
        HTTPClient.sharedInstance.execute(type: .get, endpoint: .allPrices, params: nil, success: { (json) in
            if let prices = APIParser.parseAllPrices(json: json) {
                completion(prices, nil)
            } else {
                completion(nil, BinanceError.parsingFailed)
            }
        }, failed: { (error) in
            completion(nil, error)
        })
    }

    func getPrice(for symbol: String, completion: @escaping SymbolPriceCompletion) {
        getAllPrices { (prices, error) in
            guard let prices = prices else {
                completion(nil, error)
                return
            }

            if let symbolPrice = prices[symbol] {
                completion(symbolPrice, nil)
            } else {
                completion(nil, BinanceError.parsingFailed)
            }
        }
    }

    func getDepth(for symbol: String, limit: Int?, completion: @escaping DepthCompletion) {
        var params: [String: String] = [APIConstants.symbol: symbol]
        if let limit = limit {
            params[APIConstants.limit] = String(limit)
        }

        HTTPClient.sharedInstance.execute(type: .get, endpoint: .depth, params: params, success: { (json) in
            if let depth = APIParser.parseSymbolDepth(symbol: symbol, json: json) {
                completion(depth, nil)
            } else {
                completion(nil, BinanceError.parsingFailed)
            }
        }, failed: { (error) in
            completion(nil, error)
        })
    }
}

typealias AllPricesCompletion = (_ prices: [String: Double]?, _ error: BinanceError?) -> Void
typealias SymbolPriceCompletion = (_ price: Double?, _ error: BinanceError?) -> Void
typealias DepthCompletion = (_ depth: Depth?, _ error: BinanceError?) -> Void
