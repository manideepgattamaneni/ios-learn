//
//  ExpenseItem.swift
//  My Finances
//
//  Created by Manideep Gattamaneni on 2/5/24.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
