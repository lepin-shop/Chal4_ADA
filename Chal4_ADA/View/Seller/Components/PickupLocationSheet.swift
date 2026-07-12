//
//  PickupLocationSheet.swift
//  Chal4_ADA
//
//  Created by Filipus Darren Siswanto on 12/07/26.
//

import SwiftUI

struct PickupLocationSheet: View {
    
    @Binding var location: String

    @Environment(\.dismiss) private var dismiss

    @State private var query: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                searchField

                currentLocationRow

                Spacer()
            }
            .background(Color.white)
            .navigationTitle("Ubah Lokasi Jemput")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.primary)
                        
                            
                    }
                    .accessibilityLabel("Tutup")
                    
                }
            }
        }
    }

    private var searchField: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField("", text: $query, prompt: Text("Masukkan Lokasi").foregroundColor(Color(.label)))
                .autocorrectionDisabled()
                .accessibilityLabel("Masukkan Lokasi")

            Image(systemName: "mic.fill")
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 24))
        .padding(.horizontal, 18)
        .padding(.top, 12)
        .padding(.bottom, 8)
    }

    private var currentLocationRow: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.horizontal, 18)

            Button {
                // TODO: ambil lokasi terkini pengguna
                location = "Lokasi Terkini"
                dismiss()
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "location.fill")
                        .font(.caption)
                        .foregroundStyle(.white)
                        .frame(width: 23, height: 23)
                        .background(Circle().fill(Color(.systemGray3)))
                    Text("Lokasi Terkini")
                        .foregroundStyle(Color(.systemGray))
                    Spacer()
                }
                .foregroundStyle(.secondary)
                .padding(.horizontal, 18)
                .padding(.vertical, 14)
                .contentShape(Rectangle())
            }
        }
    }
}

#Preview {
    PickupLocationSheet(location: .constant("Pasar Modern BSD"))
}
