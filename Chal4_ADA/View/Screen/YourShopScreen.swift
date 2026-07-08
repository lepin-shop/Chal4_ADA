//
//  YourShopScreen.swift
//  Chal4_ADA
//
//  Created by Danniel on 03/07/26.
//

import SwiftUI

struct YourShopScreen: View {
    @StateObject private var navigationVM = NavigationViewModel()
    
    var body: some View {
        NavigationStack (path: $navigationVM.path) {
            ScrollView {
                VStack (alignment: .leading, spacing: 0) {
                    BannerCard {
                        navigationVM.goToPost()
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
                switch route {
                case .post:
                    PostItemScreen()
                        .toolbar(
                            .hidden,
                            for: .tabBar)
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}

