//
//  ExpenseView.swift
//  iExpense
//
//  Created by Sajib Ghosh on 13/01/24.
//

import SwiftUI
import SwiftData

struct ExpenseView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    var body: some View {
        List{
            let personal = expenses.filter{$0.type == "Personal"}
            let busniness = expenses.filter{$0.type == "Business"}
            
            Section((personal.count > 0) ? "Personal" : ""){
                ForEach(personal, id: \.id){ item in
                    HStack{
                        VStack(alignment: .leading) {
                            Text(item.name).font(.headline)
                            Text(item.type)
                        }
                        .accessibilityElement()
                        Spacer()
                        Text(item.amount,format:.currency(code: item.currency)).foregroundColor((item.amount >= 10) ? ((item.amount >= 100) ? .green : .yellow) : .red)
                    }
                }.onDelete(perform: removeRows)
            }
            
            Section((busniness.count > 0) ? "Business" : ""){
                ForEach(busniness, id: \.id){ item in
                    HStack{
                        VStack(alignment: .leading) {
                            Text(item.name).font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount,format:.currency(code: item.currency)).foregroundColor((item.amount >= 10) ? ((item.amount >= 100) ? .green : .yellow) : .red)
                    }
                    
                }.onDelete(perform: removeRows)
            }

            
        }.navigationTitle("iExpenses")
    }
    
    init(filterOption: String) {
        if filterOption != "All" {
            _expenses = Query(filter: #Predicate<ExpenseItem> { item in
                item.type == filterOption
            })
        }
        
    }
    
    func removeRows(at offset: IndexSet) {
        let item = expenses[offset.first ?? 0]
        modelContext.delete(item)
    }
}

#Preview {
    ExpenseView(filterOption: "Personal")
}
