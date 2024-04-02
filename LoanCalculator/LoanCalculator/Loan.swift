//
//  Loan.swift
//  LoanCalculator
//
//  Created by Manideep Gattamaneni on 3/30/24.
//

import Foundation

struct Loan: Identifiable, Codable {
    var id = UUID()
    let name: String
    let loanAmount: Double
    let rateOfInterest: Double
    let loanTermInYears: Int

    
    static func LoanList() -> [Loan] {
        [
            Loan(name: "Home", loanAmount: 100000.0, rateOfInterest: 0.06, loanTermInYears: 30),
            Loan(name: "Car", loanAmount: 30000, rateOfInterest: 0.06, loanTermInYears: 5)
        ]
    }
}
