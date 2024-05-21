//
//  Expense.swift
//  iExpense
//
//  Created by Sajib Ghosh on 13/01/24.
//

import Foundation
import SwiftData

@Model
class ExpenseItem {
    var id = UUID()
    let name: String
    let type: String
    let currency: String
    let amount: Double
    
    init(id: UUID = UUID(), name: String, type: String, currency: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.currency = currency
        self.amount = amount
    }
}
