//
//  AddView.swift
//  Practice4
//
//  Created by Sajib Ghosh on 06/01/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    var habits: Habits
    @State private var name = String()
    @State private var description = String()
    var body: some View {
        NavigationStack{
            Form{
                TextField("Name", text: $name)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add Habit")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save"){
                        let item = HabitItem(name: name, description: description, count: 0)
                        habits.items.append(item)
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
        }
        
        
    }
}

#Preview {
    AddView(habits: Habits())
}
