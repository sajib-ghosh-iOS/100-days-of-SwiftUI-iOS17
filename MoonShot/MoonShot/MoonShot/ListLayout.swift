//
//  ListLayout.swift
//  MoonShot
//
//  Created by Sajib Ghosh on 26/12/23.
//

import SwiftUI

struct ListLayout: View {
    let astronauts: [String: Astronaut]
    let missions : [Mission]
    var body: some View {
        List{
            ForEach(missions) { mission in
                NavigationLink(value: mission) {
                    ListCellView(mission: mission)
                }
            }
        }
        .navigationDestination(for: Mission.self) { mission in
            MissionView(mission: mission, astronauts: astronauts)
        }
        /*
        ScrollView{
            LazyVGrid(columns:columns){
                ForEach(missions) { mission in
                    NavigationLink{
                        MissionView(mission: mission, astronauts: astronauts)
                    }label: {
                        
                        
                    }
                }
            }.padding([.horizontal,.bottom])
        }
        */
    }
}

#Preview {
    ListLayout(astronauts: [:], missions: [])
}
