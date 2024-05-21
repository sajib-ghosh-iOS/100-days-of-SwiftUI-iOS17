//
//  AddView.swift
//  iExpense
//
//  Created by Sajib Ghosh on 16/12/23.
//

import SwiftUI
import SwiftData

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var name = "Add new expenses"
    @State private var type = "Personal"
    @State private var currency = "USD"
    @State private var amount = 0.0
    let types = ["Business","Personal"]
    let currencies = ["USD","INR"]
    //var expenses: Expenses
    var body: some View {
        NavigationStack{
            Form{
                //TextField("Name", text: $name, prompt: nil)
                Picker("Type", selection: $type) {
                    ForEach(types,id:\.self){
                        Text($0)
                    }
                }
                Picker("Currency", selection: $currency) {
                    ForEach(currencies,id:\.self){
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: currency)).keyboardType(.decimalPad)
            }
            //.navigationTitle("Add new expense")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save"){
                        let item = ExpenseItem(name: name, type: type, currency: currency, amount: amount)
                        //expenses.items.append(item)
                        modelContext.insert(item)
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel"){
                        dismiss()
                    }
                } 
            }
            .navigationBarBackButtonHidden()
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
