//
//  FeedbackScreen.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 09/07/26.
//

import Foundation
import Combine
import SwiftUI

struct FeedbackScreen: View {
    @State private var timeRemaining = 3
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Image("FeedbackView")
                .resizable()
                .aspectRatio(contentMode: .fit)
            // 3. Text Content
            VStack(spacing: 12) {
                Text("Pesanan diterima")
                    .font(.title2.weight(.bold))
                    .foregroundStyle(.primary)
                
                Text("Silakan menuju lokasi penjemputan untuk menyelesaikan transaksi")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            
            Spacer()
            
            // 4. Action Button & Timer
            VStack(spacing: 16) {
                Button(action: {
//                    onDone()
                }) {
                    Text("Ke Halaman Belanja")
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color(.systemBackground))
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 4)
                }
                .padding(.horizontal, 40)
                
                // Dynamic Timer Text
                HStack(spacing: 4) {
                    Text("00:\(String(format: "%02d", timeRemaining))")
                        .font(.caption.weight(.bold))
                    
                    Text("Otomatis kembali ke halaman belanja")
                        .font(.caption.italic())
                }
                .foregroundStyle(Color.red.opacity(0.8))
            }
            .padding(.bottom, 40)
        }
        .background(Color(.systemGroupedBackground))
        // Timer Logic
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
//                onDone()
            }
        }
    }
}

#Preview {
    FeedbackScreen()
}
