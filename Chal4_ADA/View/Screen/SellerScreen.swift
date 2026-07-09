//
//  SellerScreen.swift
//  Chal4_ADA
//
//  Created by Danniel on 08/07/26.
//

import SwiftUI

struct SellerScreen: View {
    @StateObject private var route: AppRouter = AppRouter.shared
    
    var body: some View {
        NavigationStack (path: $route.path) {
            VStack {
                HStack {
                    Text("Jual").font(.largeTitle.bold())
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(Color.background)
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Tambah Post", systemImage: "plus") {
                        
                    }
                }
                
                ToolbarSpacer(placement: .topBarTrailing)
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Notifikasi", systemImage: "bell") {
                        
                    }
                    .badge(3)
                }
            }
        }
    }
}

#Preview {
    SellerScreen()
}
