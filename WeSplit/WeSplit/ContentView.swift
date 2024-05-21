//
//  ContentView.swift
//  WeSplit
//
//  Created by Sajib Ghosh on 13/08/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var noOfPeople = 2
    @State private var tipPercentage = 20
    private let tipPercentages = [10,15,20,0]
    
    @FocusState private var amountIsFocused: Bool
    
    var currentType: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    var totalPerPerson: Double{
        let peopleCount = Double(noOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount/100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal/peopleCount
        return amountPerPerson
    }
    
    var totalAmount: Double{
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount/100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: currentType)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $noOfPeople) {
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                Section{
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101){
                            Text($0,format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip you want to leave?")
                }
                Section{
                    Text(totalAmount,format: currentType)
                        .foregroundColor((tipPercentage == 0) ? .red : .white)
                }header: {
                    Text("Total amount for check")
                }
                Section{
                    Text(totalPerPerson,format: currentType)
                }header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
