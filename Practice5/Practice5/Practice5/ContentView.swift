//
//  ContentView.swift
//  Practice5
//
//  Created by Sajib Ghosh on 13/01/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    //@State private var users = [User]()
    @Query private var users : [User]
    @State private var showLoading = false
    @Environment(\.modelContext) var modelContext
    var body: some View {
        NavigationStack{
            if showLoading {
                ProgressView()
            }else{
                List(users, id:\.id) { user in
                    NavigationLink(value: user){
                        VStack(alignment: .leading){
                            Text(user.name)
                            Text(user.isActive ? "Active" : "Inactive")
                                .foregroundStyle(user.isActive ? .green : .red)
                        }
                    }
                }
                .navigationDestination(for: User.self, destination: { user in
                    UserDetailsView(user: user)
                })
                .onAppear(perform: {

                    Task{
                        if users.count == 0 {
                            try await fetchUsers()
                        }
                    }
                })
            }
        }
        .navigationTitle("Users")
    }
    
    func fetchUsers() async throws {
        print("fetchUsers....")
        let config =  URLSessionConfiguration.default
        let urlSession = URLSession(configuration: config)
        do{
            guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else{
                fatalError("Not able to get url")
            }
            let (data,response) = try await urlSession.data(from: url)
            showLoading = false
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw CustomError.invalidResponse
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            do{
                showLoading = false
                let users = try decoder.decode([User].self, from: data)
                for user in users {
                    modelContext.insert(user)
                }
                
                let a : Character = "a"
                let i = Int(a.asciiValue ?? 0)
            }catch{
                showLoading = false
                throw error

            }
        }catch{
            showLoading = false
            throw error
        }
    }
}

#Preview {
    ContentView()
}
