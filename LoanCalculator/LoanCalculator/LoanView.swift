//
//  LoanView.swift
//  LoanCalculator
//
//  Created by Manideep Gattamaneni on 3/30/24.
//

import SwiftUI

struct LoanView: View {
    @State var loanAmount: Double
    @State var rateOfInterest: Double
    @State var loanTermInYears: Int
    
    func calculatePaymentsByMonth(principal: Double,M: Double, r: Double) -> [Payment] {
        var starting_balance = 0.0
        let a = (1.0 + r)
        var payments = [Payment]()
        for i in 0..<loanTermInYears*12{
            if (i == 0){
                starting_balance = principal
            }else{
                starting_balance = starting_balance * a - M
            }
            
            let interestAmount = starting_balance * r
            let ending_balance = starting_balance < M ? 0.0 : roundToTwoDecimal(starting_balance * a - M)
            payments.append(Payment(month: i+1, principal: roundToTwoDecimal(M - interestAmount), interest: roundToTwoDecimal(interestAmount), endingBalance: roundToTwoDecimal(ending_balance)))
        }
       return payments
    }
    
    func roundToTwoDecimal(_ value: Double) -> Double {return round(value * 100)/100.0}
    var body: some View {
        let r = rateOfInterest/12
        let numberOfPaymentsInMonths = Double(loanTermInYears * 12)
        let a = pow(Double(1 + r), numberOfPaymentsInMonths)
        let monthlyPayment = r * loanAmount * a / (a - 1)
        
        let total_interest = monthlyPayment * numberOfPaymentsInMonths - loanAmount
        
        let total_amount = monthlyPayment * numberOfPaymentsInMonths
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
                }
                Section("Estimated"){
                    HStack{
                        Text("Monthly Payment")
                        Spacer()
                        Text(monthlyPayment,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    HStack{
                        Text("Total Interest")
                        Spacer()
                        Text(total_interest,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    HStack{
                        Text("Total Amount")
                        Spacer()
                        Text(total_amount,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    
                }
                
            }
            NavigationLink("View Amortization table"){
                PaymentView(payments: calculatePaymentsByMonth(principal: loanAmount, M: monthlyPayment, r: r), monthlyPayment: monthlyPayment)
            }.buttonStyle(.borderedProminent)
            .navigationTitle("Loan Details").navigationBarTitleDisplayMode(.inline)
        }.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    LoanView(loanAmount: 100000, rateOfInterest: 0.06, loanTermInYears: 30)
}
