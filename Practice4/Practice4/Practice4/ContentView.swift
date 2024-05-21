//
//  ContentView.swift
//  Practice4
//
//  Created by Sajib Ghosh on 06/01/24.
//

import SwiftUI

struct HabitItem: Identifiable, Codable, Hashable, Equatable {
    var id = UUID()
    let name: String
    let description: String
    var count: Int
}

@Observable
class Habits {
    var items = [HabitItem]() {
        didSet{
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "items") {
            if let decoded = try? JSONDecoder().decode([HabitItem].self, from: savedItems) {
                items = decoded
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    @State private var isPresented = false
    @State private var habits = Habits()
    @State private var items = [HabitItem]()
    var body: some View {
        NavigationStack{
            List{
                ForEach(items, id: \.id){ item in
                    NavigationLink(value: item){
                        VStack(alignment: .leading){
                            Text(item.name).font(.headline).foregroundStyle(.white)
                            Text(item.description).foregroundStyle(.white)
                        }
                    }
                }.onDelete(perform: { indexSet in
                    habits.items.remove(atOffsets: indexSet)
                })
                .listRowBackground(Color.green)
            }
            .navigationDestination(for: HabitItem.self, destination: { item in
                HabitDetailsView(item: item, habits: habits)
            })
            .navigationTitle("Habit Tracker")
            .toolbar{
                Button("Add habit", systemImage: "plus") {
                    isPresented.toggle()
                }
            }
            .sheet(isPresented: $isPresented, content: {
                AddView(habits: habits)
            })
            .listRowBackground(Color.red)
            //.preferredColorScheme(.dark)
            //.accentColor(.white)
        }
        
    }
}

#Preview {
    ContentView()
}
