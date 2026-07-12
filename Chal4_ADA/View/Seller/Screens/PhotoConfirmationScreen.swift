//
//  PhotoConfirmationScreen.swift
//  Chal4_ADA
//
//  Created by Filipus Darren Siswanto on 12/07/26.
//

import SwiftUI

struct PhotoConfirmationScreen: View {
    let photos: [UIImage]
    var labels: [String] = ["Depan", "Belakang", "Atas", "Bawah"]

    var onContinue: () -> Void = {}
    var onRetake: () -> Void = {}
    var onCancel: () -> Void = {}

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

    var body: some View {
        VStack(spacing: 0) {
            topBar

            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(Array(photos.enumerated()), id: \.offset) { index, photo in
                        photoCell(photo, label: index < labels.count ? labels[index] : "")
                    }
                }
                .padding(16)
            }

            Button {
                onRetake()
            } label: {
                Text("Ambil ulang foto")
                    .font(.headline)
                    .foregroundStyle(.destructive)
                    .padding(.horizontal, 28)
                    .padding(.vertical, 14)
                    .background(Color.destructive.opacity(0.06), in: Capsule())
                    .overlay(
                        Capsule().stroke(Color.destructive.opacity(0.4), lineWidth: 1.5)
                    )
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 20)
        }
        .background(Color.background)
    }

    private var topBar: some View {
        ZStack {
            Text("Konfirmasi Foto")
                .font(.headline)
                .foregroundStyle(.primary)

            HStack {
                Button {
                    onCancel()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.black)
                        .frame(width: 38, height: 38)
                        .background(Color(.systemGray5), in: Circle())
                        
                }
                .accessibilityLabel("Kembali")

                Spacer()

                Button {
                    onContinue()
                } label: {
                    Text("Lanjut")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 8)
                        .background(Color.accents, in: Capsule())
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }

    private func photoCell(_ photo: UIImage, label: String) -> some View {
        // Cell rasio 3:4 (potret) agar foto kamera (yang juga 3:4)
        // terisi penuh tanpa crop aneh, dan seragam untuk keempatnya.
        Color.clear
            .aspectRatio(3.0 / 4.0, contentMode: .fit)
            .overlay {
                Image(uiImage: photo)
                    .resizable()
                    .scaledToFill()
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(alignment: .bottom) {
                Text(label)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 7)
                    .background(Color.black.opacity(0.55), in: RoundedRectangle(cornerRadius: 12))
                    .padding(10)
            }
    }
}
