//
//  MissionView.swift
//  MoonShot
//
//  Created by Sajib Ghosh on 25/12/23.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView: View {

    let mission: Mission
    let crew: [CrewMember]
    
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }

    
    var body: some View {
        ScrollView{
            VStack{
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                Text(mission.formattedLaunchDateAndTime)
                VStack(alignment: .leading){
                    RectangleDividerView()
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    Text(mission.description)
                    RectangleDividerView()
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }.padding(.horizontal)
                
                CrewMemberView(crew: crew)
            }.padding(.bottom)
        }.navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
        let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

        return MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
}
