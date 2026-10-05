//
//  Shot.swift
//  ShotTracker
//

import Foundation
import SwiftData

/// Outcome of the single shot.
enum ShotOutcome: String, Codable, CaseIterable, Identifiable {
    case goal = "Goal"
    case save = "Save"

    var id: String { rawValue }
}

/// A single shot, persisted locally first (SwiftData) so the app works fully
/// offline. `isSynced` tracks whether this record has been pushed to Firestore
/// yet; see SyncEngine.
@Model
final class Shot {
    @Attribute(.unique) var id: String
    var outcome: ShotOutcome

    // Fractions (0...1) of the tap-target's own width/height at the moment
    // of the tap - see TapPointView - not device points or pixels. That
    // makes them portable across any screen size: (0.5, 0.5) is always dead
    // center no matter what device recorded it. start = where on the field
    // (LacrosseField artwork) the shot was taken; finish = where in the net
    // square it went.
    var startX: Double
    var startY: Double
    var finishX: Double
    var finishY: Double
    var createdAt: Date
    var updatedAt: Date
    var isSynced: Bool

    var game: Game?

    init(id: String = UUID().uuidString,
         outcome: ShotOutcome,
         startX: Double,
         startY: Double,
         finishX: Double,
         finishY: Double,
         createdAt: Date = .now,
         game: Game? = nil) {
        self.id = id
        self.outcome = outcome
        self.startX = startX
        self.startY = startY
        self.finishX = finishX
        self.finishY = finishY
        self.createdAt = createdAt
        self.updatedAt = createdAt
        self.isSynced = false
        self.game = game
    }
}
