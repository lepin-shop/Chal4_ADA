//
//  Chal4_ADAApp.swift
//  Chal4_ADA
//
//  Created by Filipus Darren Siswanto on 02/07/26.
//

import SwiftUI
import SwiftData

@main
struct Chal4_ADAApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(SessionManager.shared)
        }
        .modelContainer(sharedModelContainer)
    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([User.self, Item.self, Order.self, Follow.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}
