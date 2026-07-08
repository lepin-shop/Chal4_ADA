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
    @State private var session = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(session)
        }
        .modelContainer(for: [User.self, Item.self, Tag.self, Order.self])
    }
}
