//
//  ContentView.swift
//  LoanCalculator
//
//  Created by Manideep Gattamaneni on 1/19/24.
//

import SwiftUI
import Charts

struct ContentView: View {
    @State var loans = [Loan(name: "Home", loanAmount: 100000.0, rateOfInterest: 0.06, loanTermInYears: 30),
                        Loan(name: "Car", loanAmount: 30000, rateOfInterest: 0.06, loanTermInYears: 5)]
    var body: some View {
        NavigationStack{
            
            List{
                ForEach(loans){loan in
                        NavigationLink(loan.name){
                            LoanView(loanAmount: loan.loanAmount, rateOfInterest: loan.rateOfInterest, loanTermInYears: loan.loanTermInYears)
                           
                        }
                    
                }
            }.navigationTitle("Loans")
        }
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        
    }
}


#Preview {
    ContentView(loans: Loan.LoanList())
}
