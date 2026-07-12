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
    @ObservedObject private var router = AppRouter.shared
    
    var body: some View {
        TabView {
            if SessionManager.shared.role == .buyer {
                Tab ("Beli", systemImage: "storefront.fill") {
                    BuyerScreen()
                        .id(SessionManager.shared.activeUserID)
                }
                
            } else {
                Tab ("Jual", systemImage: "storefront.fill") {
                    NavigationStack(path: $router.path) {
                        EmptyGoodsScreen(onSell: { router.push(.post) })
                            .navigationDestination(for: Route.self) { route in
                                RouteDestinationView(route: route)
                            }
                    }
                    .tint(.black)
                    
                }
            }
            
            Tab ("Notifikasi", systemImage: "bell.fill") {
                NotificationScreen()
                    .id(SessionManager.shared.activeUserID)
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
