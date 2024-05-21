//
//  ContentView.swift
//  Project6
//
//  Created by Sajib Ghosh on 11/05/24.
//
import PhotosUI
import SwiftUI
import SwiftData

@Model
class User: Identifiable, Comparable, Hashable {
    
    var id = UUID()
    @Attribute(.externalStorage) var image: Data
    var name: String
    var lat: Double
    var long: Double
    var swiftUIImage: Image {
        let inputImage = UIImage(data: image)
        return Image(uiImage: inputImage!)
    }
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.name < rhs.name
    }
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id && lhs.image == rhs.image
    }
    init(id: UUID = UUID(), image: Data, name: String, lat: Double, long: Double) {
        self.id = id
        self.image = image
        self.name = name
        self.lat = lat
        self.long = long
    }
}
struct ContentView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Data?
    @Query(sort: \User.name) var users: [User]
    //@State private var users = [User]()
    @State private var showingAlert = false
    @State private var name = ""
    @Environment(\.modelContext) var modelContext
    let locationFetcher = LocationFetcher()
    var body: some View {
        NavigationStack {
            VStack {
                if !users.isEmpty {
                    List {
                        ForEach(users) { user in
                            NavigationLink(value: user) {
                                HStack {
                                    user.swiftUIImage
                                        .resizable()
                                        .frame(width:50, height: 50)
                                    Text(user.name)
                                }
                            }
                        }
                    }
                    .navigationDestination(for: User.self, destination: { user in
                        ContactDetailsView(user: user)
                    })
                }else {
                    PhotosPicker(selection: $selectedItem) {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to export a photo"))
                    }
                    .onChange(of: selectedItem, loadImage)
                    .onChange(of: selectedImage) {
                        showingAlert = true
                    }
                }
                /*
                    PhotosPicker(selection: $selectedItem) {
                        if !users.isEmpty {
                            List {
                                ForEach(users) { user in
                                    NavigationLink(value: user) {
                                        HStack {
                                            user.swiftUIImage
                                                .resizable()
                                                .frame(width:50, height: 50)
                                            Text(user.name)
                                        }
                                    }
                                }
                            }
                            .navigationDestination(for: User.self, destination: { user in
                                ContactDetailsView(user: user)
                            })
                        }else {
                            ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to export a photo"))
                        }
                    }
                    .onChange(of: selectedItem, loadImage)
                    .onChange(of: selectedImage) {
                        showingAlert = true
                    }
                 */
                }
            .navigationTitle("Contact list")
            .alert("Enter your name", isPresented: $showingAlert) {
                TextField("Enter your name", text: $name)
                Button("OK"){
                    if let selectedImage {
                        let user = User(image: selectedImage, name: name, lat: locationFetcher.lastKnownLocation?.latitude ?? 22.46, long: locationFetcher.lastKnownLocation?.longitude ?? 88.32)
                        modelContext.insert(user)
                        
                    }
                }}
            .onAppear(perform: {
                locationFetcher.start()
            })
            }
    }
    func loadImage() {
        Task {
            if let image = try await self.selectedItem?.loadTransferable(type: Data.self) {
                self.selectedImage = image
            }
        }
    }
        
    }

#Preview {
    ContentView()
}
