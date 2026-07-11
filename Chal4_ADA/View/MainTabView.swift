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
    var body: some View {
        TabView {
            Tab ("Jual", systemImage: "storefront.fill") {

            }
            
            Tab ("Notifikasi", systemImage: "bell.fill") {

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
