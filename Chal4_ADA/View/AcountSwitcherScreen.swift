//
//  ChangeAccoutScreen.swift
//  Chal4_ADA
//
//  Created by Danniel on 12/07/26.
//

import SwiftUI
import SwiftData

struct AccountSwitcherScreen: View {
    @StateObject private var router: AppRouter = AppRouter.shared
    @Query(sort: \User.name) private var users: [User]

    var body: some View {
        VStack(spacing: 0) {
            List(users) { user in
                Button {
                    switchAccount(to: user)
                } label: {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.name)
                                .font(.headline)
                            Text(user.phone)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        if SessionManager.shared.currentUser?.id == user.id {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                        }
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
            .listStyle(.plain)
        }
        .navigationTitle("Pilih Akun")
    }

    private func switchAccount(to user: User) {
        SessionManager.shared.setActiveUser(user, role: .buyer)
        router.popToRoot()
    }
}

#Preview {
    NavigationStack {
        AccountSwitcherScreen()
            .environment(SessionManager.shared)
            .modelContainer(AppContainer.shared.modelContainer)
    }
}
