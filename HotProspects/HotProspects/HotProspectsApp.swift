//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Sajib Ghosh on 12/05/24.
//

import SwiftUI
import SwiftData
@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
