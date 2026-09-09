//
//  ContentView.swift
//  ShotTracker
//
//  Created by Luke Bloomer on 9/1/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var store = ShotStore()

    @State private var outcome: ShotOutcome = .save
    @State private var startX: Double?
    @State private var startY: Double?
    @State private var finishX: Double?
    @State private var finishY: Double?

    private var isComplete: Bool {
        startX != nil && startY != nil && finishX != nil && finishY != nil
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Outcome") {
                    Picker("Goal / Save", selection: $outcome) {
                        ForEach(ShotOutcome.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Shot start (on field)") {
                    coordRow("Start X", value: $startX)
                    coordRow("Start Y", value: $startY)
                }

                Section("Shot finish (in goal)") {
                    coordRow("Finish X", value: $finishX)
                    coordRow("Finish Y", value: $finishY)
                }

                Section {
                    Button("Save shot") {
                        Task { await saveShot() }
                    }
                    .disabled(!isComplete)

                    if store.savedCount > 0 {
                        Text("Saved \(store.savedCount) shot(s)")
                            .foregroundStyle(.secondary)
                    }
                    if let error = store.lastError {
                        Text(error).foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle("New Shot")
        }
    }

    private func coordRow(_ label: String, value: Binding<Double?>) -> some View {
        HStack {
            Text(label)
            Spacer()
            TextField("0", value: value, format: .number)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: 120)
                #if os(iOS)
                .keyboardType(.decimalPad)
                #endif
        }
    }

    private func saveShot() async {
        guard let sx = startX, let sy = startY,
              let fx = finishX, let fy = finishY else { return }

        let shot = Shot(outcome: outcome,
                        startX: sx, startY: sy,
                        finishX: fx, finishY: fy)
        await store.save(shot)

        if store.lastError == nil {
            startX = nil; startY = nil; finishX = nil; finishY = nil
        }
    }
}

#Preview {
    ContentView()
}
