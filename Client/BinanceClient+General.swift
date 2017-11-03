//
//  BinanceClient+General.swift
//  BinanceSwift
//
//  Created by Ali Ravanchi on 11/2/17.
//  Copyright © 2017 Cardinal Labs. All rights reserved.
//

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
