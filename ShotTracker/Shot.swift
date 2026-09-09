//
//  Shot.swift
//  ShotTracker
//

import Foundation

/// Outcome of the single shot.
enum ShotOutcome: String, Codable, CaseIterable, Identifiable {
    case goal = "Goal"
    case save = "Save"

    var id: String { rawValue }
}

/// Single shot struct - contains 5 properties for testing purposes - will be expanded in the future.
struct Shot: Codable, Identifiable {
    var id: String = UUID().uuidString
    var outcome: ShotOutcome
    var startX: Double
    var startY: Double
    var finishX: Double
    var finishY: Double
    var createdAt: Date = Date()
}
