//
//  ProfileView.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 08/07/26.
//

import Foundation
import SwiftUI

// MARK: - Dummy Data Models
struct PartnerGroup: Identifiable {
    let id = UUID()
    let name: String
    let memberColors: [Color] // Using colors to mock the overlapping avatars
}

struct Partner: Identifiable {
    let id = UUID()
    let name: String
    let phone: String
}

// MARK: - Main View
struct ProfiileView: View {
    
    // Mock Data based on your screenshot
    private let groups = [
        PartnerGroup(name: "Jeruk", memberColors: [.black, .blue, .pink, .yellow, .green, .gray.opacity(0.3)]),
        PartnerGroup(name: "Semangka", memberColors: [.black, .blue, .pink, .yellow, .green, .gray.opacity(0.3)]),
        PartnerGroup(name: "Apel", memberColors: [.black, .blue, .pink, .yellow, .green, .gray.opacity(0.3)]),
        PartnerGroup(name: "Stroberi", memberColors: [.black, .blue, .pink, .yellow, .green, .gray.opacity(0.3)])
    ]
    
    private let partners = [
        Partner(name: "Marno Kompos", phone: "+62 857 7878 9862"),
        Partner(name: "Lastri Sayur", phone: "+62 857 7878 9862")
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // 2. Grup Mitra Section
                    VStack(spacing: 16) {
                        sectionHeader(title: "Grup Mitra", buttonTitle: "+ Grup Baru")
                        
                        ForEach(groups) { group in
                            GroupCardView(group: group)
                        }
                    }
                    
                    // 3. Mitra Kamu Section
                    VStack(spacing: 16) {
                        sectionHeader(title: "Mitra kamu", buttonTitle: "+ Mitra Baru")
                        
                        ForEach(partners) { partner in
                            PartnerCardView(partner: partner)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 100) // Padding for tab bar
            }
            .navigationTitle("Mitra")
            .background(Color(.systemGroupedBackground))
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape")
                    }
                    .tint(.primary)
                    .tint(.primary)
                    
                    // Bell Icon with Native Badge
                    Button("Notifications", systemImage: "bell", action: {
                        print("Notifications tapped")
                    })
                    .badge(3) // <-- Your native badge!
                    .tint(.primary)
                }
            }
        }
    }
    
    // MARK: - Header Section
    
    
    // MARK: - Reusable Section Header
    private func sectionHeader(title: String, buttonTitle: String) -> some View {
        HStack {
            Text(title)
                .font(.title2.weight(.bold))
            
            Spacer()
            
            Button(action: {}) {
                HStack(spacing: 4) {
                    Text(buttonTitle)
                        .font(.subheadline.weight(.medium))
                }
                .foregroundStyle(.primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color(.systemBackground))
                .clipShape(Capsule())
            }
        }
    }
}

// MARK: - Group Card View
struct GroupCardView: View {
    let group: PartnerGroup
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                Text(group.name)
                    .font(.headline)
                
                HStack(spacing: -10) {
                    ForEach(0..<group.memberColors.count, id: \.self) { index in
                        Circle()
                            .fill(group.memberColors[index])
                            .frame(width: 28, height: 28)
                            .overlay(
                                Circle()
                                    .stroke(Color(.systemBackground), lineWidth: 2)
                            )
                    }
                }
            }
            
            Spacer()
            
            Button(action: {}) {
                Text("Atur")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.primary)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

// MARK: - Partner Card View
struct PartnerCardView: View {
    let partner: Partner
    
    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(Color(.systemGray4))
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: "person.fill")
                        .foregroundStyle(.white)
                        .font(.title2)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(partner.name)
                    .font(.headline)
                
                Text(partner.phone)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "person.2.badge.minus")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.red.opacity(0.7))
                    .padding(10)
                    .background(Color.red.opacity(0.1))
                    .clipShape(Circle())
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

// MARK: - Preview with Tab Bar wrapper
#Preview {
    ProfiileView()
        .tint(.green)
}

