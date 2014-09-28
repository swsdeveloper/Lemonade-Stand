//
//  Customer.swift
//  Lemonade Stand
//
//  Created by Steven Shatz on 9/27/14.
//  Copyright (c) 2014 Steven Shatz. All rights reserved.
//

import Foundation

struct Customer {
    
    var sweetnessPreference: Sweetness.SweetnessPreference?
    var willBuyLemonade: Bool
    
    init() {
        sweetnessPreference = nil
        willBuyLemonade = false
    }
        
    static func randomlyGenerateNumberOfCustomers(maxCustomers: Int) -> Int {
        return Int(arc4random_uniform(UInt32(maxCustomers))) + 1
    }
    
}
