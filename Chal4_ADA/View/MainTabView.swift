//
//  MainTabView.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 02/07/26.
//

import Foundation
import SwiftUI

struct MainTabView: View {
    @ObservedObject private var router = AppRouter.shared

    var body: some View {
        TabView {
            Tab ("Jual", systemImage: "storefront.fill") {
                NavigationStack(path: $router.path) {
                    EmptyGoodsScreen(onSell: { router.push(.post) })
                        .navigationDestination(for: Route.self) { route in
                            RouteDestinationView(route: route)
                        }
                }
                .tint(.black)
            }
            Tab ("Notification", systemImage: "bell.fill") {
                YourShopScreen()
                    .tint(.black)
            }
            Tab("Profile", systemImage: "person.fill") {
                ProfiileView()
                    .tint(.black)
            }
        }.tint(.accents)
    }
}

#Preview {
    MainTabView()
        .environment(SessionManager.shared)
}
