//
//  PaymentView.swift
//  LoanCalculator
//
//  Created by Manideep Gattamaneni on 3/29/24.
//

import SwiftUI

struct PaymentView: View {
    var payments = [Payment]()
    var monthlyPayment:Double
    var body: some View {
        VStack{
            List{
                Section("Estimated"){
                    HStack{
                        Text("Monthly Payment")
                        Spacer()
                        Text(monthlyPayment,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                }
                Section("Amortization schedule"){
                    HStack{
                        Text("Month").frame(maxWidth: .infinity,alignment: .center)
                        Divider()
                        Text("Interest").frame(maxWidth: .infinity, alignment: .center)
                        Divider()
                        Text("principal").frame(maxWidth: .infinity,alignment: .center)
                    }
                    ForEach(payments) { payment in
                        HStack {
                            Text(payment.month, format: .number).frame(maxWidth: .infinity,alignment: .center)
                            Divider()
                            Text(payment.interest, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).frame(maxWidth: .infinity,alignment: .center)
                            Divider()
                            Text(payment.principal, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).frame(maxWidth: .infinity,alignment: .center)
                        }
                    }
                }
            }
        }.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

#Preview {

    PaymentView(payments: Payment.examples(), monthlyPayment: 3450.7895)
}
