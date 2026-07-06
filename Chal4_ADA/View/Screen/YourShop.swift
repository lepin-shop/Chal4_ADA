//
//  YourShop.swift
//  Chal4_ADA
//
//  Created by Danniel on 03/07/26.
//

import SwiftUI

struct YourShop: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (alignment: .leading, spacing: 0) {
                    Banner()
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
}

