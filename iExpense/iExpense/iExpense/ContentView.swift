//
//  ContentView.swift
//  iExpense
//
//  Created by Sajib Ghosh on 13/12/23.
//

import SwiftUI
import SwiftData

struct User: Codable{
    var firstName: String
    var lastName: String
}

struct SecondView: View{
    @Environment(\.dismiss) var dismiss
    let name: String
    var body: some View{
        VStack{
            Text(name)
            Button("Dismiss"){
                dismiss()
            }
        }
    }
}

/*
struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let currency: String
    let amount: Double
}
@Observable
class Expenses {
    var items = [ExpenseItem](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        items = []
    }
    
}
*/

struct ContentView: View {
    @State private var user = User(firstName: "Sajib", lastName: "Ghosh")
    @State private var isShowing = false
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    @AppStorage("tapCount") private var tapCount = 0
    @State private var getUser: User?
    
    //@State private var expenses = Expenses()
    @Environment(\.modelContext) var modelContext
    @State private var filterOption = "Business"
    private var filterOptions = ["Business","Personal","All"]
//    @Query(filter: #Predicate<ExpenseItem> { item in
//        item.type == filterOption
//    }, sort:[SortDescriptor(\ExpenseItem.amount, order: .reverse)]) var expenses : [ExpenseItem]
    @State private var items = [ExpenseItem]()
    @State private var showingAdExpense = false

    var body: some View {
        /*
        Text("User name is \(user.firstName) \(user.lastName)")
        if #available(iOS 15.0, *) {
            TextField(user.firstName, text: $user.firstName, prompt: nil)
            TextField(user.lastName, text: $user.lastName, prompt: nil)
        } else {
            // Fallback on earlier versions
        }
        
        Button("Show me"){
            isShowing.toggle()
        }.sheet(isPresented: $isShowing){
            if #available(iOS 15.0, *) {
                SecondView(name: "Second Viewwwwww")
            } else {
                // Fallback on earlier versions
            }
        }
        */
        /*
        NavigationView{
            VStack{
                List{
                    ForEach(numbers,id:\.self){
                        Text("Number: \($0)")
                    }.onDelete(perform: removeRows)
                }
                Button("Add number"){
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }.toolbar {
                EditButton()
            }
        }
        */
        
        /*
        Button("Tap count:\(tapCount)"){
            tapCount += 1
        }
         */
        /*
        VStack{
            Button("Save Data"){
                let encoder = JSONEncoder()
                if let data = try? encoder.encode(user) {
                    UserDefaults.standard.set(data, forKey: "UserData")
                }
            }
            
            Button("get Data"){
                let decoder = JSONDecoder()
                let data = UserDefaults.standard.data(forKey: "UserData")
                if let user = try? decoder.decode(User.self, from: data!) {
                    getUser = user
                }
            }
            if getUser != nil {
                Text("FirstName: \(getUser?.firstName ?? "")")
                Text("LastName: \(getUser?.lastName ?? "")")
            }
            
        }
        */
        NavigationStack{
            ExpenseView(filterOption: filterOption)
            .navigationTitle("iExpenses")
                .toolbar{
                    Button("Add expense",systemImage: "plus") {
                        showingAdExpense = true
                    }
                    Menu("Filter",systemImage: "option") {
                        Picker("Filtter", selection: $filterOption) {
                            ForEach(filterOptions,id:\.self){
                                Text($0)
                            }
                            
                        }
                    }
                }.navigationDestination(isPresented: $showingAdExpense, destination: {
                    //Show Add view
                    AddView()
                })
                
//                .sheet(isPresented: $showingAdExpense) {
//                    //Show Add view
//                    AddView(expenses: expenses)
//                }
        }

    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
