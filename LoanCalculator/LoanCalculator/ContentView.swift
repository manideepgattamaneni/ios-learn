//
//  ContentView.swift
//  LoanCalculator
//
//  Created by Manideep Gattamaneni on 1/19/24.
//

import SwiftUI
import Charts

struct ContentView: View {
    @State private var loanAmount = 440380.0
    @State private var rateOfInterest = 0.02875
    @State private var loanTermInYears = 30
    
    func dumpPayments(principal: Double,M: Double, r: Double) {
        var starting_balance = 0.0
        let a = (1.0 + r)
        var total_int = 0.0
        var payments = [Int: Payment]()
        for i in 0..<360{
            if (i == 0){
                starting_balance = principal
            }else{
                starting_balance = starting_balance * a - M
            }
            
            let interestAmount = starting_balance * r
            let ending_balance = starting_balance < M ? 0.0 : roundToTwoDecimal(starting_balance * a - M)
            payments[i] = Payment(principal: roundToTwoDecimal(M - interestAmount), interest: roundToTwoDecimal(interestAmount), endingBalance: roundToTwoDecimal(ending_balance))
        }
        
        dump(payments.sorted(by:  { $0.0 < $1.0 }))
    }
    
    func roundToTwoDecimal(_ value: Double) -> Double {return round(value * 100)/100.0}
    
    
    
    var body: some View {
        let r = rateOfInterest/12
        let numberOfPaymentsInMonths = Double(loanTermInYears * 12)
        let a = pow(Double(1 + r), numberOfPaymentsInMonths)
        let monthlyPayment = r * loanAmount * a / (a - 1)
        
        let total_interest = monthlyPayment * numberOfPaymentsInMonths - loanAmount
        
        let total_amount = monthlyPayment * numberOfPaymentsInMonths
        
        var chartData:  [(type: String, amount: Double)]{
            [(type:"principal", amount:loanAmount),
             (type:"interest", amount:total_interest)]
        }
        NavigationStack{
            List{
                Group{
                    Section("Loan Amount"){
                        TextField("Enter the loan amount", value: $loanAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    
                    Section("Annual Interest rate"){
                        TextField("Enter the interest rate", value: $rateOfInterest, format: .percent)
                    }
                    
                    Section("Loan term"){
                        TextField("Enter the number of years", value:$loanTermInYears, format: .number )
                    }
                    
                    Section("Monthly Payment"){
                        Text(monthlyPayment, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    
                    Section("Total Interest"){
                        Text(total_interest, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                }
                //            Text("Total Interest: \(getTotalInterest(principal:loanAmount,M: monthlyPayment,r:r),specifier: "%.2f")")
                Section{
                    Text("Total estimated amount: \(total_amount, specifier: "%.2f")")
                    Chart(chartData, id:\.type) { dataItem in
                        SectorMark(angle: .value("Type", dataItem.amount),
                                   innerRadius: .ratio(0.5),
                                   angularInset: 1.5)
                        .cornerRadius(5)
                        .foregroundStyle(by:.value("Type", dataItem.type))
                    }.chartLegend(position: .top, spacing: 20).frame(height:200)
                    
                }
                Button("View amortization table"){
                    dumpPayments(principal: loanAmount, M: monthlyPayment, r: r)
                }
                    
            }
            .navigationTitle("Loan Calculator").navigationBarTitleDisplayMode(.inline)
        }.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        
    }
}

class Payment {
    let principal: Double
    let interest: Double
    let endingBalance: Double

    init(principal: Double, interest: Double, endingBalance: Double) {
        self.principal = principal
        self.interest = interest
        self.endingBalance = endingBalance
    }
}

#Preview {
    ContentView()
}
