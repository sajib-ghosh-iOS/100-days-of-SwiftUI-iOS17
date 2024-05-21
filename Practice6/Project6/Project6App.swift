//
//  Project6App.swift
//  Project6
//
//  Created by Sajib Ghosh on 11/05/24.
//

import SwiftUI

@main
struct Project6App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
