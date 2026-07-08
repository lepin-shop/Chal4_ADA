//
//  SettingsView.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 08/07/26.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @Environment(SessionManager.self) private var session
    @State private var showSwitchAccountSheet = false
    
    private let allUsers: [User] = [ItemsData.siti, ItemsData.budi]
    private var currentUser: User? {
        session.resolveCurrentUser(in: allUsers)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                // 1. Profile Summary Card
                HStack(spacing: 16) {
                    Circle()
                        .fill(Color.green.opacity(0.2))
                        .frame(width: 60, height: 60)
                        .overlay(
                            Text("?")
                                .font(.title2.weight(.bold))
                                .foregroundStyle(Color.green)
                        )
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(currentUser?.name ?? "")
                            .font(.title3.weight(.bold))
                        Text(currentUser?.phone ?? "Silakan pilih akun")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                }
                .padding(20)
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 24))
                
                // 2. Settings Menu Card
                VStack(spacing: 0) {
                    settingsRow(icon: "person.text.rectangle", title: "Informasi Akun")
                    Divider().padding(.leading, 48)
                    settingsRow(icon: "bell.badge", title: "Notifikasi")
                    Divider().padding(.leading, 48)
                    settingsRow(icon: "lock.shield", title: "Privasi & Keamanan")
                    Divider().padding(.leading, 48)
                    settingsRow(icon: "questionmark.circle", title: "Pusat Bantuan")
                }
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 24))
                
                // 3. Logout / Keluar Button
                Button(action: {
                    showSwitchAccountSheet = true
                }) {
                    Text("Ganti Akun")
                        .font(.headline)
                        .foregroundStyle(Color.green)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.red.opacity(0.1))
                        .clipShape(Capsule())
                }
                .padding(.top, 8)
                .popover(isPresented: $showSwitchAccountSheet) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Berikut akun yang tertera pada perangkat saat ini.")
                            .font(.subheadline)
                            .foregroundStyle(.primary)
                            .padding(.bottom, 4)
                        ForEach(allUsers, id: \.id) { user in
                            Button(action: {
                                session.setActiveUser(user)
                                showSwitchAccountSheet = false
                            }) {
                                Text("\(user.name)")
                                    .font(.subheadline.weight(.medium))
                                    .foregroundStyle(Color.green)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(Color(.systemGray5))
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    .padding(20)
                    .presentationCompactAdaptation(.popover)
                }
                
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Pengaturan")
        .navigationBarTitleDisplayMode(.large)
    }
    
    // MARK: - Reusable Row Component
    private func settingsRow(icon: String, title: String) -> some View {
        Button(action: {
            // Action for row tap
        }) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .frame(width: 24) // Ensures icons align perfectly
                
                Text(title)
                    .font(.body.weight(.medium))
                    .foregroundStyle(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color(.tertiaryLabel))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .tint(.green)
            .environment(SessionManager())
    }
}
