//
//  Extensions.swift
//  My Finances
//
//  Created by Manideep Gattamaneni on 3/14/24.
//

import Foundation

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.currencyCode ?? "USD")
    }
}
