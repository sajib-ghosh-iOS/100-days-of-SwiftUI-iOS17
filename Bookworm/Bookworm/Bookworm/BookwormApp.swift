//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Sajib Ghosh on 10/01/24.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
            .modelContainer(for: Book.self)
    }
}
