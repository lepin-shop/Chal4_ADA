//
//  MainTabView.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 02/07/26.
//

import Foundation
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Text("Your Shop")
                .tabItem {
                    Label("Your Shop", systemImage: "basket")
                }
            ConnectionView()
                .tabItem {
                    Label("Your Need", systemImage: "person.3.fill")
                }
            Text("Profile")
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .tint(.green)
    }
}

#Preview {
    MainTabView()
}
