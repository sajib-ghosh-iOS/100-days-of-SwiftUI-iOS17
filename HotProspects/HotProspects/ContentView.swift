//
//  ContentView.swift
//  HotProspects
//
//  Created by Sajib Ghosh on 12/05/24.
//

import SwiftUI
import UserNotifications
struct ContentView: View {
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    @State private var selection = Set<String>()
    @State private var selectedState = "One"
    @State private var output = ""
    @State private var backgroundColor = Color.red
    
    var body: some View {
        /*
        List(users, id: \.self, selection: $selection) { user in
            Text(user)
        }
        if !selection.isEmpty {
            Text("You selected \(selection.formatted())")
        }
        EditButton()
        */
        /*
        TabView(selection: $selectedState) {
            Button("Show tab 2") {
                selectedState = "Two"
            }
            .tabItem { Label("One", systemImage: "star") }
            .tag("One")
            Text("Tab 2")
                .tabItem { Label("Two", systemImage: "circle") }
                .tag("Two")
         */
        /*
            Text(output)
            .task {
                await fetchReadings()
            }
        */
        /*
        Text("Hello, World!")
        .padding()
        .background(backgroundColor)

        Text("Change Color")
            .padding()
            .contextMenu {
                Button("Red", systemImage: "checkmark.circle.fill", role: .destructive) {
                    backgroundColor = .red
                }

                Button("Green") {
                    backgroundColor = .green
                }

                Button("Blue") {
                    backgroundColor = .blue
                }
            }
         */
        /*
        List {
            Text("Taylor Swift")
                .swipeActions {
                    Button("Delete", systemImage: "minus.circle", role: .destructive) {
                        print("Deleting")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button("Pin", systemImage: "pin") {
                        print("Pinning")
                    }
                    .tint(.orange)
                }
        }
        */
        /*
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }

            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default

                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                // add our notification request
                UNUserNotificationCenter.current().add(request)

            }
        }
        */
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                    .tabItem {
                        Label("Me", systemImage: "person.crop.square")
                    }
        }
    }
    
    func fetchReadings() async {
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        
        let result = await fetchTask.result
        do {
            output = try result.get()
        } catch {
            output = "Error: \(error.localizedDescription)"
        }
        
        switch result {
        case .success(let str):
            output = str
        case .failure(let error):
            output = "Error: \(error.localizedDescription)"
        }
    }
}

#Preview {
    ContentView()
}
