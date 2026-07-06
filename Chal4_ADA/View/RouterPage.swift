//
//  HomePage.swift
//  Chal4_ADA
//
//  Created by Danniel on 02/07/26.
//

import SwiftUI

struct RouterPage: View {
    var body: some View {
        TabView {
            Tab ("Your Shop", systemImage: "storefront.fill") {
                NavigationStack {
                    ScrollView {
                        YourShop()
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
            Tab ("Connection", systemImage: "person.3.fill") {
                
            }
            Tab ("Profile", systemImage: "person.fill") {
                
            }
        }
        .tint(.accent)
    }
}

#Preview {
    RouterPage()
}
