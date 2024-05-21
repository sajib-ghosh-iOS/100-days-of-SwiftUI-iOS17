//
//  FriendsView.swift
//  Practice5
//
//  Created by Sajib Ghosh on 14/01/24.
//

import SwiftUI

struct FriendsView: View {
    
    let friends: [Friend]
    
    var body: some View {
        VStack(alignment: .leading){
            ForEach(friends,id: \.id){ friend in
                Text(friend.name)
            }
        }
    }
}

#Preview {
    FriendsView(friends: [])
}
