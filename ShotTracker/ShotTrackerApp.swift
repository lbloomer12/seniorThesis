//
//  ShotTrackerApp.swift
//  ShotTracker
//
//  Created by Luke Bloomer on 9/1/26.
//

import SwiftUI
import FirebaseCore

@main
struct ShotTrackerApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
