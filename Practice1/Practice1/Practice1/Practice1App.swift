//
//  Practice1App.swift
//  Practice1
//
//  Created by Sajib Ghosh on 25/11/23.
//

import SwiftUI

@main
struct Practice1App: App {
    var body: some Scene {
        WindowGroup {
            if #available(iOS 15.0, *) {
                ContentView()
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
