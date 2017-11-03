//
//  BinanceClient+General.swift
//  BinanceSwift
//
//  Created by Ali Ravanchi on 11/2/17.
//  Copyright © 2017 Cardinal Labs. All rights reserved.
//

import Foundation

typealias PingCompletion = (_ error: Error?) -> Void
typealias ServerTimeCompletion = (_ time: Int?, _ error: Error?) -> Void

protocol GeneralClientInterface {
    /**
     Test connectivity to the Rest API.
     */
    func ping(completion: @escaping PingCompletion)

    /**
     Test connectivity to the Rest API and get the current server time.
     */
    func getServerTime(completion: @escaping ServerTimeCompletion)
}

extension BinanceClient: GeneralClientInterface {
    func ping(completion: @escaping PingCompletion) {
        HTTPClient.sharedInstance.execute(type: .GET, endpoint: .ping, params: nil, success: { (json) in
            completion(nil)
        }, failed: { (error) in
            completion(error)
        })
    }

    func getServerTime(completion: @escaping ServerTimeCompletion) {
        HTTPClient.sharedInstance.execute(type: .GET, endpoint: .time, params: nil, success: { (json) in
            let serverTime = json[APIConstants.serverTime] as? Int
            completion(serverTime, nil)
        }, failed: { (error) in
            completion(nil, error)
        })
    }
}
