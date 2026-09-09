//
//  ShotStore.swift
//  ShotTracker
//

import Foundation
import Combine
import FirebaseFirestore

/// Sends shots to Cloud Firestore database.
@MainActor
final class ShotStore: ObservableObject {
    @Published var savedCount = 0
    @Published var lastError: String?

    func save(_ shot: Shot) async {
        do {
            let data = try Firestore.Encoder().encode(shot)
            try await Firestore.firestore()
                .collection("shots")
                .document(shot.id)
                .setData(data)
            savedCount += 1
            lastError = nil
        } catch {
            lastError = error.localizedDescription
        }
    }
}
