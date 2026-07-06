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
            Tab ("Your Shop", systemImage: "storefront.fill") {
                YourShop()
            }
            Tab ("Connection", systemImage: "person.3.fill") {
                ConnectionView()
            }
            Tab ("Profile", systemImage: "person.fill") {
                
            }
        }.tint(.accents)
    }
}

#Preview {
    MainTabView()
}
