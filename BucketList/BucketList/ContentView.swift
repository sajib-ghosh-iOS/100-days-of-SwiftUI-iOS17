//
//  ContentView.swift
//  BucketList
//
//  Created by Sajib Ghosh on 08/05/24.
//
import MapKit
import SwiftUI

struct User: Comparable, Identifiable {
    let id = UUID()
    let firstName: String
    let lastName: String
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ContentView: View {
    
//    let users = [
//        User(firstName: "Sajib", lastName: "Ghosh"),
//        User(firstName: "Rahul", lastName: "Das"),
//        User(firstName: "Saurav", lastName: "Tandon")
//    ].sorted()
    
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    @State private var viewModel = ViewModel()
    @State private var isStandardMap = true
    @State private var isBiometricNotAvailable = false
    var body: some View {
        /*
        List(users) { user in
            Text("\(user.lastName), \(user.firstName)")
        }
        
        Button("Read and Write") {
            let data = Data("Test Message".utf8)
            let url = URL.documentsDirectory.appending(path: "message.txt")
            do {
                try data.write(to: url)
                let input = try String(contentsOf: url)
                print(input)
            } catch {
                print(error.localizedDescription)
            }
        }
         */
        
        if viewModel.isUnLocked {
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                        }
                    }
                }
                .mapStyle(isStandardMap ? .standard : .hybrid)
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.addLocation(at: coordinate)
                    }
                }
            }
            .sheet(item: $viewModel.selectedPlace) { place in
                EditView(location: place) {
                    viewModel.update(location: $0)
                }
            }
            HStack {
                Button("Standard") {
                    isStandardMap = true
                }
                Button("Hybrid") {
                    isStandardMap = false
                }
            }
        } else {
            Button("Unlock Places", action: {
                viewModel.authenticate { success in
                   isBiometricNotAvailable = success
                }
            })
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .alert(isPresented: $isBiometricNotAvailable, content: {
                    Alert(title: Text("Biometric not available"))
                })
        }

    }
}


#Preview {
    ContentView()
}
