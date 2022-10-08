//
//  Cash.swift
//  A1_P2_Kim_YongHwan
//
//  Created by YongHwan Kim on 2019/09/02.
//  Copyright © 2019 YongHwan Kim. All rights reserved.
//

import Foundation

public class Cash {
    //dollars and cents
    public var money: Double
    // Count each level of money rates
    public var billCoinCount: Array<Int>? {
        get {
            if money < 0 {
                return nil
            }
            var temp = money
            var tempArray: Array<Int> = []
            let moneyAmount: Array<Double> = [50, 20, 10, 5, 1, 0.25, 0.1, 0.05, 0.01]
            
            for bill in moneyAmount {
                var count: Int = 0
                while temp >= bill {
                    count = count + 1
                    temp = round(1000 * (temp - bill)) / 1000
                }
                tempArray.append(count)
            }
            
            return tempArray
        }
    }
    // Constructer
    public init(money: Double) {
        self.money = money
    }
}
