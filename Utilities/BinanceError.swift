//
//  BinanceError.swift
//  BinanceSwift
//
//  Created by Ali Ravanchi on 11/3/17.
//  Copyright © 2017 Cardinal Labs. All rights reserved.
//

import Foundation

enum BinanceError: Error {
    case parsingFailed
    case noResponse
    case failedResponse
}
