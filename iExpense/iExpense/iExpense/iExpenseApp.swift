//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Sajib Ghosh on 13/12/23.
//

import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
