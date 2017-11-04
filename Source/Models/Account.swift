//
//  Account.swift
//  BinanceSwift
//
//  Created by Ali Ravanchi on 11/3/17.
//  Copyright © 2017 Cardinal Labs. All rights reserved.
//

class Account {
    public private(set) var makerCommission: Int = 0
    public private(set) var takerCommission: Int = 0
    public private(set) var buyCommission: Int = 0
    public private(set) var sellerCommission: Int = 0
    public private(set) var canTrade: Bool = false
    public private(set) var canWithdraw: Bool = false
    public private(set) var canDeposit: Bool = false
    public private(set) var balances: [Balance] = []

    convenience init(makerCommission: Int, takerCommission: Int, buyCommission: Int, sellerCommission: Int, canTrade: Bool, canWithdraw: Bool, canDeposit: Bool, balances: [Balance]) {
        self.init()
        self.makerCommission = makerCommission
        self.takerCommission = takerCommission
        self.buyCommission = buyCommission
        self.sellerCommission = sellerCommission
        self.canTrade = canTrade
        self.canWithdraw = canWithdraw
        self.canDeposit = canDeposit
        self.balances = balances
    }
}
