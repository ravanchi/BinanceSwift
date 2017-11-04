//
//  ViewController.swift
//  BinanceSwift
//
//  Created by Ali Ravanchi on 11/2/17.
//  Copyright © 2017 Cardinal Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let basicClient = BinanceClient()

//        basicClient.ping { (error) in
//            if let error = error {
//                // There was an error communicating with the Binance API servers!
//                print(error)
//            } else {
//                print("Successfully pinged the Binance API Servers!")
//            }
//        }
//
//        basicClient.getServerTime { (epochTime, error) in
//            if let error = error {
//                // There was an error communicating with the Binance API servers!
//                print(error)
//            } else {
//                print("We got the server time! It is: \(epochTime!)")
//                print(String(Date().timeIntervalSince1970))
//            }
//        }

//        basicClient.getAllPrices { (prices, error) in
//            guard let prices = prices else {
//                print("Error in getting all prices!")
//                return
//            }
//
//            print(prices)
//        }

//        basicClient.getDepth(for: "LTCBTC", limit: nil) { (depth, error) in
//            guard let depth = depth else {
//                print("Error in getting the depth!")
//                return
//            }
//
//            print(depth)
//        }

        let authedClient =  BinanceClient(apiKey: "", secretKey: "")

        authedClient.getAccount { (account, error) in
            // Not handling error in example
            guard let account = account else {
                return print("Error getting account information!")
            }

            print(account)
        }


    }
}

