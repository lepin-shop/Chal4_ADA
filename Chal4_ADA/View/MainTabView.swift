//
//  MainTabView.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 02/07/26.
//

import Foundation
import SwiftUI
import SwiftData

struct MainTabView: View {
    @Query private var notifications: [Notification]
    
    init() {
        let userId = SessionManager.shared.currentUser?.id
        let predicate = #Predicate<Notification> { $0.user?.id == userId }
        _notifications = Query(filter: predicate, sort: [SortDescriptor(\.timestamp, order: .reverse)])
    }
    
    var body: some View {
        TabView {
            Tab ("Jual", systemImage: "storefront.fill") {

            }
            
            if notifications.isEmpty {
                Tab ("Notifikasi", systemImage: "bell.fill") {
                    NotificationScreen()
                }
            } else {
                Tab ("Notifikasi", systemImage: "bell.fill") {
                    NotificationScreen()
                }.badge(notifications.count)
            }

            Tab ("Profil", systemImage: "person.fill") {
                ProfileScreen()
            }
        }
        .tint(.accents)
    }
}

#Preview {
    MainTabView()
        .environment(SessionManager.shared)
        .modelContainer(AppContainer.shared.modelContainer)
}
