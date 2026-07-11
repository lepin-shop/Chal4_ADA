//
//  ProfileScreen.swift
//  Chal4_ADA
//
//  Created by Danniel on 11/07/26.
//

import SwiftUI
import SwiftData

struct ProfileScreen: View {
    @StateObject private var router: AppRouter = AppRouter.shared
    
    var body: some View {
        NavigationStack (path: $router.path) {
            VStack {
                
            }
            .navigationTitle("Profil \(SessionManager.shared.role.rawValue)")
            .toolbar {
                ToolbarItem(id: "Logout", placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.forward")
                    }
                    .tint(.destructivem1)
                }
            }
        }
    }
}

#Preview {
    ProfileScreen()
        .environment(SessionManager.shared)
        .modelContainer(AppContainer.shared.modelContainer)
}
