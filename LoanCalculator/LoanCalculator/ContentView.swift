//
//  ContentView.swift
//  LoanCalculator
//
//  Created by Manideep Gattamaneni on 1/19/24.
//

import SwiftUI

struct ContentView: View {
    @State private var loanAmount = 440380.0
    @State private var rateOfInterest = 2.875/100
    @State private var numberOfPaymentsInMonths = 360.0
    
    func getTotalInterest(principal: Double,M: Double, r: Double)-> Double {
        var starting_balance = 0.0
        let a = (1.0 + r)
        var total_int = 0.0
        for i in 0..<360{
            if (i == 0){
                starting_balance = principal
            }else{
                starting_balance = starting_balance * a - M
            }
            
            let interestAmount = starting_balance * r
            let balance = starting_balance < M ? 0.0 : roundToTwoDecimal(starting_balance * a - M)
            total_int = total_int + interestAmount
            
            print("Month \(i+1) - \(roundToTwoDecimal(starting_balance))(BB) - \(roundToTwoDecimal(interestAmount))(I) - \(roundToTwoDecimal(M-interestAmount))(P) - \(balance)(EB) ")
        }
        print("BB = Begining Balance, I = Interest, P = Principal, EB = Ending Balance")
        return roundToTwoDecimal(total_int)
    }
    
    func roundToTwoDecimal(_ value: Double) -> Double {return round(value * 100)/100.0}
    
    
    
    var body: some View {
        let r = rateOfInterest/12
        let a = pow(Double(1 + r), numberOfPaymentsInMonths)
        let monthlyPayment = r * loanAmount * a / (a - 1)
        VStack {
            
            Text("Monthly payment: \(monthlyPayment, specifier: "%.2f")")
            Text("Total Interest: \(getTotalInterest(principal:loanAmount,M: monthlyPayment,r:r),specifier: "%.2f")")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
