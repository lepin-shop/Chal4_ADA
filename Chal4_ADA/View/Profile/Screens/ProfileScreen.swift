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
                ProfileCard().padding(.top, 20)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
            .navigationTitle("Profil \(SessionManager.shared.role.rawValue)")
            .toolbar {
                ToolbarItem(id: "Logout", placement: .topBarTrailing) {
                    Button {
                        router.push(.switchAccount)
                    } label: {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.forward")
                    }
                    .tint(.destructivem1)
                }
            }.navigationDestination(for: Route.self) { route in
                RouteDestinationView(route: route)
            }
        }
    }
}

#Preview {
    ProfileScreen()
        .environment(SessionManager.shared)
        .modelContainer(AppContainer.shared.modelContainer)
}
