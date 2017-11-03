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

//        client.ping { (error) in
//            if let error = error {
//                // There was an error communicating with the Binance API servers!
//                print(error)
//            } else {
//                print("Successfully pinged the Binance API Servers!")
//            }
//        }
//
//        client.getServerTime { (epochTime, error) in
//            if let error = error {
//                // There was an error communicating with the Binance API servers!
//                print(error)
//            } else {
//                print("We got the server time! It is: \(epochTime!)")
//            }
//        }

//        client.getAllPrices { (prices, error) in
//            guard let prices = prices else {
//                print("Error in getting all prices!")
//                return
//            }
//
//            print(prices)
//        }

//        client.getDepth(for: "LTCBTC", limit: nil) { (depth, error) in
//            guard let depth = depth else {
//                print("Error in getting the depth!")
//                return
//            }
//
//            print(depth)
//        }



    }
}

