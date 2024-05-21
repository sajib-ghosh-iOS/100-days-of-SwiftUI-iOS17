//
//  ListCellView.swift
//  MoonShot
//
//  Created by Sajib Ghosh on 26/12/23.
//

import SwiftUI

struct ListCellView: View {
    let mission: Mission
    var body: some View {
        VStack{
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100,height: 100)
                .padding()
            VStack{
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundStyle(.white)
                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.lightBackground)
        }
        .clipShape(.rect(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(.lightBackground)
        )
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    return ListCellView(mission: missions[0])
}
