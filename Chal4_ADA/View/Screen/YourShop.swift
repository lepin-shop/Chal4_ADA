//
//  YourShop.swift
//  Chal4_ADA
//
//  Created by Danniel on 03/07/26.
//

import SwiftUI

struct YourShop: View {
    @Environment(SessionManager.self) private var session
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (alignment: .leading, spacing: 0) {
                    BannerCard()
                    .padding(.bottom, 24)
                   
                    YourPostsSection()
                    Spacer()
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
                            .tint(.black)
                        }
                    }
            }
            .background(Color.background)
        }
    }
}

#Preview {
    MainTabView()
        .environment(SessionManager())
}

