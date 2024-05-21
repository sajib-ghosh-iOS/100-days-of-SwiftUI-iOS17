//
//  AstronautView.swift
//  MoonShot
//
//  Created by Sajib Ghosh on 25/12/23.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    var body: some View {
        ScrollView{
            VStack{
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                Text(astronaut.description).padding()
            }
            .background(.darkBackground)
            .navigationTitle(astronaut.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    let astronauts: [String:Astronaut] = Bundle.main.decode("astranauts.json")
    return AstronautView(astronaut: astronauts["aldrin"]!)
}
