//
//  BinanceClient+General.swift
//  BinanceSwift
//
//  Created by Ali Ravanchi on 11/2/17.
//  Copyright © 2017 Cardinal Labs. All rights reserved.
//

extension BinanceClient: GeneralClientInterface {
    func ping(completion: @escaping PingCompletion) {
        HTTPClient.sharedInstance.execute(type: .get, endpoint: .ping, params: nil, success: { (json) in
            completion(nil)
        }, failed: { (error) in
            completion(error)
        })
    }

    func getServerTime(completion: @escaping ServerTimeCompletion) {
        HTTPClient.sharedInstance.execute(type: .get, endpoint: .time, params: nil, success: { (json) in
            if let serverTime = APIParser.parseServerTime(json: json) {
                completion(serverTime, nil)
            } else {
                completion(nil, BinanceError.parsingFailed)
            }
        }, failed: { (error) in
            completion(nil, error)
        })
    }
}

typealias PingCompletion = (BinanceError?) -> Void
typealias ServerTimeCompletion = (_ time: Int?, _ error: BinanceError?) -> Void
