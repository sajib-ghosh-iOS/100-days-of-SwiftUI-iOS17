//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Sajib Ghosh on 12/01/24.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
