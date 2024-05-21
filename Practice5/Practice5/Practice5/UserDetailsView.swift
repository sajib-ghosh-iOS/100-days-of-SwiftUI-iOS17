//
//  UserDetailsView.swift
//  Practice5
//
//  Created by Sajib Ghosh on 14/01/24.
//

import SwiftUI

struct UserDetailsView: View {
    let user: User
    var body: some View {
        ScrollView{
            VStack{
                VStack(alignment: .leading){
                    Text("Name:\(user.name)")
                    Text("Registered:\(user.formattedRegisteredDate)")
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.background)
                        .padding(.vertical)
                    
                    Text("Friends")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }.padding()
                
                FriendsView(friends: user.friends)
            }
        }
        .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
        
        
    }
}

#Preview {
    do{
        let decoder = JSONDecoder()
        return try UserDetailsView(user: User(from: decoder as! Decoder))
    }catch{
        return Text("Error:\(error.localizedDescription)")
    }
    
}
