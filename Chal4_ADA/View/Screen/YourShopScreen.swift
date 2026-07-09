//
//  YourShopScreen.swift
//  Chal4_ADA
//
//  Created by Danniel on 03/07/26.
//

import SwiftUI

struct YourShopScreen: View {
    @ObservedObject private var router = AppRouter.shared
    
    var body: some View {
        NavigationStack (path: $router.path) {
            ScrollView {
                VStack (alignment: .leading, spacing: 0) {
                    BannerCard {
                        router.push(Route.post)
                    } .padding(.bottom, 24)
                    
                    YourPostsSection()
                    Spacer()
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 28)
            .navigationTitle("Activities")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItem {
                    Button("Account", systemImage: "bell", action: {}
                           
                    )
                    .badge(3)
                }
            }
            
            .background(Color(.background))
            .navigationDestination (for: Route.self) {
                route in
                RouteDestinationView(route: route)
            }
        }
    }
}

#Preview {
    MainTabView()
}

