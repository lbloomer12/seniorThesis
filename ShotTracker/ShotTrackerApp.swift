//
//  ShotTrackerApp.swift
//  ShotTracker
//
//  Created by Luke Bloomer on 9/1/26.
//

import SwiftUI
import SwiftData
import FirebaseCore

@main
struct ShotTrackerApp: App {
    @StateObject private var auth = AuthService()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(auth)
        }
        .modelContainer(for: [Game.self, Shot.self])
    }
}
