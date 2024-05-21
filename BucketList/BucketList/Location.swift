//
//  Location.swift
//  BucketList
//
//  Created by Sajib Ghosh on 08/05/24.
//

import Foundation
import MapKit
struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
    #if DEBUG
    static let example = Location(id: UUID(), name: "example", description: "", latitude: 0.0, longitude: 0.0)
    #endif
}
