//
//  ContentView.swift
//  My Finances
//
//  Created by Manideep Gattamaneni on 1/29/24.
//

import SwiftUI
import Observation

@Observable
class Expenses{
    var items = [ExpenseItem](){
        didSet {
                if let encoded = try? JSONEncoder().encode(items) {
                    UserDefaults.standard.set(encoded, forKey: "Items")
                }
            }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

        var body: some View {
            NavigationStack {
                List {
                    ForEach(expenses.items) { item in
                        HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }

                                Spacer()
                            Text(item.amount, format:.localCurrency).foregroundColor(item.amount < 10 ? .green : item.amount < 100 ? .indigo : .red)
                            }
                    }.onDelete(perform: removeItems)
                }
                .navigationTitle("My Finances")
                .toolbar {
                    Button("Add Expense", systemImage: "plus") {
                        showingAddExpense = true
                    }
                }
            }.sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    
}

#Preview {
    ContentView()
}
