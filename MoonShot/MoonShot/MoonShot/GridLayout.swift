//
//  GridLayout.swift
//  MoonShot
//
//  Created by Sajib Ghosh on 26/12/23.
//

import SwiftUI

struct GridLayout: View {
    
    let astronauts: [String: Astronaut]
    let missions : [Mission]
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        ScrollView{
            LazyVGrid(columns:columns){
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        ListCellView(mission: mission)
                    }
                }
            }
            .padding([.horizontal,.bottom])
            .navigationDestination(for: Mission.self) { mission in
                MissionView(mission: mission, astronauts: astronauts)
            }
        }
    }
}

#Preview {
    GridLayout(astronauts: [:], missions: [])
}
