//
//  ProfileCardView.swift
//  Chal4_ADA
//
//  Created by Danniel on 11/07/26.
//


import SwiftUI
import SwiftData

struct ProfileCard: View {
    @State private var showPopover = false
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(.accent4)
                            .frame(width: 56, height: 56)
                        Image(systemName: "person.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(SessionManager.shared.currentUser?.name ?? "Danniel")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        Text(SessionManager.shared.currentUser?.phone ?? "082136390957")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Button {
                        if SessionManager.shared.role == .seller {
                            SessionManager.shared.role = .buyer
                        } else {
                            SessionManager.shared.role = .seller
                        }
                    } label : {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.title3)
                            .foregroundColor(.accent4)
                            .frame(width: 44, height: 44)
                    }
                    .glassEffect()
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 16)
                .background(Color.white)
                
                if SessionManager.shared.role == .seller {
                    Text("Pemilik Warung")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color.accent1, location: 0.0),
                                    .init(color: Color.accents, location: 0.58),
                                    .init(color: Color.accentm3, location: 1.0)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
            
            VStack(spacing: 0) {
                if SessionManager.shared.role == .seller {
                    ProfileDetailRow(label: "Nama Toko", value: "Toko buah \(SessionManager.shared.currentUser?.name ?? "Asep")")
                    Divider().padding(.leading, 20)
                }
                ProfileDetailRow(label: "Email", value: SessionManager.shared.currentUser?.email ?? "asep*****@gmail.com")
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        }
        .padding(.horizontal, 16)
        .background(Color(.systemGray6))
    }
}

#Preview {
    ProfileCard()
        .padding(.top, 40)
        .environment(SessionManager.shared)
        .modelContainer(AppContainer.shared.modelContainer)
}
