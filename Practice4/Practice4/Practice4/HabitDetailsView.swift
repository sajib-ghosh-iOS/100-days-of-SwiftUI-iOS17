//
//  HabitDetailsView.swift
//  Practice4
//
//  Created by Sajib Ghosh on 06/01/24.
//

import SwiftUI

struct HabitDetailsView: View {
    var item: HabitItem
    var habits: Habits
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.15, green: 0.1, blue: 0.3), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ],center: .top,startRadius: 200,endRadius: 700).ignoresSafeArea()
            
            VStack{
                VStack(alignment: .leading){
                    Text("Name: \(item.name)")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                    Text("Description: \(item.description)")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                    Text("Completed: ^[\(item.count) times](inflect:true)")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                }
                .padding(50)
                Button("Complete", systemImage: "plus") {
                    if let index = habits.items.firstIndex(of: item) {
                        habits.items[index].count += 1
                    }
                }
                .padding(20)
                .foregroundColor(.white)
                .background(.blue)
                .clipShape(Capsule())
                .font(.title.bold())
                Spacer()
            }
        }

    }

}

#Preview {
    let item = HabitItem(name: "", description: "", count: 0)
    return HabitDetailsView(item: item, habits: Habits())
}
