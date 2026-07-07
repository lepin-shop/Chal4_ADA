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
        }
        .modelContainer(for: [User.self, Item.self, Tag.self, Order.self])
    }
}
