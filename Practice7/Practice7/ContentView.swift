//
//  ContentView.swift
//  Practice7
//
//  Created by Sajib Ghosh on 17/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedSide = 0
    private var sides = Array(4...101).filter{ $0%2 == 0 }
    @State private var rolledValue = 0
    var body: some View {
        VStack {
            HStack {
                Text("Select number of sides")
                Picker("", selection: $selectedSide) {
                    ForEach(sides, id: \.self) { side in
                        Text("\(side)")
                    }
                }
            }
           
            Button("Spin") {
                print(selectedSide)
                let possibleValues = Array(4...selectedSide)
                self.rolledValue = possibleValues.randomElement() ?? 0
            }
            .padding(20)
            
            Text("Rolled value: \(rolledValue)")
            
        }
        
    }
}

#Preview {
    ContentView()
}
