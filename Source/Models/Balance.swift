//
//  Balance.swift
//  BinanceSwift
//
//  Created by Ali Ravanchi on 11/3/17.
//  Copyright © 2017 Cardinal Labs. All rights reserved.
//

class Balance {
    public private(set) var asset: String = ""
    public private(set) var free: Double = 0.0
    public private(set) var locked: Double = 0.0

    convenience init(asset: String, free: Double, locked: Double) {
        self.init()
        self.asset = asset
        self.free = free
        self.locked = locked
    }
}
