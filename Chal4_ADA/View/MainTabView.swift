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
            Tab ("Eksplor", systemImage: "storefront.fill") {
                YourShopScreen()
                    .tint(.black)
            }
            
            Tab ("Jual", systemImage: "creditcard.arrow.trianglehead.2.clockwise.rotate.90") {
                SellerScreen()
                    .tint(.black)
            }

            Tab ("Beli", systemImage: "basket") {
                
            }
            
            Tab("Mitra", systemImage: "person.line.dotted.person.fill") {
                
            }
        }.tint(.accents)
    }
}

#Preview {
    MainTabView()
        .environment(SessionManager.shared)
}
