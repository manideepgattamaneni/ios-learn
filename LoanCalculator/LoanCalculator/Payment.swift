//
//  Payment.swift
//  LoanCalculator
//
//  Created by Manideep Gattamaneni on 3/30/24.
//

import Foundation

struct Payment: Identifiable {
    var id = UUID()
    let principal: Double
    let interest: Double
    let endingBalance: Double
    let month: Int

    init(month: Int, principal: Double, interest: Double, endingBalance: Double) {
        self.month = month
        self.principal = principal
        self.interest = interest
        self.endingBalance = endingBalance
    }
    static func examples() -> [Payment] {
        [
            Payment(month: 1, principal: 1890.4567, interest: 345.2345, endingBalance: 444567.9083)
        ]
    }
}
