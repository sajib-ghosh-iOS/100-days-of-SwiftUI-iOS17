//
//  Practice5App.swift
//  Practice5
//
//  Created by Sajib Ghosh on 13/01/24.
//

import SwiftUI

@main
struct Practice5App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for:User.self)
    }
}
