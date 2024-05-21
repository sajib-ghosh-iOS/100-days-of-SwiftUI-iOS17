//
//  ContactDetailsView.swift
//  Project6
//
//  Created by Sajib Ghosh on 11/05/24.
//
import MapKit
import SwiftUI

struct ContactDetailsView: View {
    let user: User
    var body: some View {
        VStack {
            user.swiftUIImage
                .resizable()
                .scaledToFit()
            Map() {
                Annotation(user.name, coordinate: CLLocationCoordinate2D(latitude: user.lat, longitude: user.long)) {
                        Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                    }
                }
            Text(user.name)
        }
    }
}
