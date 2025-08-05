//
//  PlayingGameSwiftDataAPIApp.swift
//  PlayingGameSwiftDataAPI
//
//  Created by Fabrice Kouonang on 2025-08-05.
//

import SwiftUI
import SwiftData
@main
struct PlayingGameSwiftDataAPIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for:Score.self)
    }
}
