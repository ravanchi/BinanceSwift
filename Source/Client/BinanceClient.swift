//
//  BinanceClient.swift
//  BinanceSwift
//
//  Created by Ali Ravanchi on 11/2/17.
//  Copyright © 2017 Cardinal Labs. All rights reserved.
//

/**
Asynchronous REST API Client.
Need to instantiate client in order to start making calls to the API.

- parameter apiKey: Optional parameter which is only needed if interacting with a secure endpoint. Create one at https://www.binance.com/userCenter/createApi.html
- parameter secretKey: Optional parameter which is only needed if interacting with a secure endpoint. Create one at https://www.binance.com/userCenter/createApi.html
*/

class BinanceClient {
    public private(set) var apiKey: String?
    public private(set) var secretKey: String?

    convenience init(apiKey: String, secretKey: String) {
        self.init()
        self.apiKey = apiKey
        self.secretKey = secretKey
    }
}
