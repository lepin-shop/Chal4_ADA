//
//  PostSuccessScreen.swift
//  Chal4_ADA
//
//  Created by Filipus Darren Siswanto on 12/07/26.
//

import SwiftUI

struct PostSuccessScreen: View {
    @ObservedObject private var router = AppRouter.shared

    @State private var remaining: Int = 34

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.background
                .ignoresSafeArea()

            closeButton

            VStack(spacing: 0) {
                Spacer()

                Image(.feedbackView)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)

                Text("Dagangan berhasil disebarkan")
                    .font(.title2.bold())
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)

                Text("tunggu sampai para mitramu merespon dan membeli daganganmu")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.top, 8)

                Button {
                    goToGoods()
                } label: {
                    Text("Ke Halaman Jual")
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .padding(.vertical, 14)
                        .padding(.horizontal, 32)
                }
                .background(.white, in: Capsule())
                .overlay(
                    Capsule().stroke(Color(.systemGray4), lineWidth: 1)
                )
                .padding(.top, 32)

                Text("\(timeString) Otomatis kembali ke halaman jual")
                    .font(.footnote.italic())
                    .foregroundStyle(.destructive)
                    .padding(.top, 12)

                Spacer()
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .task {
            await runCountdown()
        }
    }

    private var closeButton: some View {
        Button {
            router.popToRoot()
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(.primary)
                .frame(width: 44, height: 44)
                .background(.white, in: Circle())
                .shadow(color: .black.opacity(0.08), radius: 6, y: 2)
        }
        .padding(.leading, 20)
        .padding(.top, 8)
        .accessibilityLabel("Tutup")
    }

    // MARK: - Countdown

    private var timeString: String {
        String(format: "%02d:%02d", remaining / 60, remaining % 60)
    }

    private func runCountdown() async {
        while remaining > 0 {
            do {
                try await Task.sleep(for: .seconds(1))
            } catch {
                return // dibatalkan saat view menghilang
            }
            remaining -= 1
        }
        goToGoods()
    }

    // MARK: - Navigation

    private func goToGoods() {
        router.replace(with: .sellerGoods)
    }
}

#Preview {
    NavigationStack {
        PostSuccessScreen()
    }
}
