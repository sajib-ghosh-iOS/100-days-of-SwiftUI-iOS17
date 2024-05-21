//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Sajib Ghosh on 18/05/24.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}
struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

@Observable
class Player {
    var name = "Anonymous"
    var highScore = 0
}

struct HighScoreView: View {
    //var player: Player
    @Environment(Player.self) var player
    var body: some View {
        @Bindable var player = player
        Text("Your high score: \(player.highScore)")
        Stepper("High score: \(player.highScore)", value: $player.highScore)
    }
}

struct ContentView: View {
    /*
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    @State private var layoutVertically = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var searchText = ""
    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]
    @State private var player = Player()
    var filteredNames: [String] {
        if searchText.isEmpty {
            allNames
        } else {
            allNames.filter { $0.localizedStandardContains(searchText) }
        }
    }
    */
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var searchText = ""
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            resorts
        } else {
            resorts.filter { $0.name.localizedStandardContains(searchText)}
        }
    }
    @State private var sortedResorts = [Resort]()
    @State private var favorites = Favorites()
    var body: some View {
        /*
        NavigationView {
            Text("Hello, world!")
                .navigationTitle("Primary")
        }
        */
        /*
        NavigationSplitView {
            //Text("Primary")
            NavigationLink("Primary") {
                Text("New data")
            }
        } detail: {
            Text("Content")
        }
        */
        /*
        Button("Tap Me") {
            selectedUser = User()
        }
        .sheet(item: $selectedUser) { user in
            Text(user.id)
                .presentationDetents([.medium, .large])
        }
        
        Button("Tap Me") {
            selectedUser = User()
            isShowingUser = true
        }
        .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
            Button(user.id) { }
        }
         */
        /*
        Button {
            layoutVertically.toggle()
        } label: {
            if layoutVertically {
                VStack {
                    UserView()
                }
            } else {
                HStack {
                    UserView()
                }
            }
        }
        
        if horizontalSizeClass == .compact {
            VStack(content: UserView.init)
        } else {
            HStack {
                HStack(content: UserView.init)
            }
        }
        */
        /*
        ViewThatFits {
            Rectangle()
                .frame(width: 500, height: 200)
            
            Circle()
                .frame(width: 200, height: 200)
        }
         */
        /*
        NavigationStack {
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: "Look for something")
            .navigationTitle("Searching")
        }
        */
        /*
        VStack {
            Text("Welcome!")
            HighScoreView()
        }
        .environment(player)
         */
        
        NavigationSplitView {
            List(sortedResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                .rect(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )

                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                            .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Menu("Sort",systemImage: "arrow.up.arrow.down") {
                    Button("Default"){ sortedResorts = filteredResorts }
                    Button("Alphabetical"){ sortedResorts.sort{$0.name < $1.name}}
                    Button("Country"){ sortedResorts.sort{$0.country < $1.country} }
                }
            }
            
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
        .onAppear {
            sortedResorts = filteredResorts
        }
    }
}

#Preview {
    ContentView()
}
