//
//  ReusableItemDetail.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 11/07/26.
//

import Foundation
import SwiftUI

struct ImageGalleryCarousel: View {
    let item: Item
    let grade: String
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            TabView {
                if item.uiImage1 != nil {
                    Image(uiImage: item.uiImage1!)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(.banana)
                        .resizable()
                        .scaledToFill()
                }
                
                if item.uiImage2 != nil {
                    Image(uiImage: item.uiImage2!)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(.banana1)
                        .resizable()
                        .scaledToFill()
                }
                
                if item.uiImage3 != nil {
                    Image(uiImage: item.uiImage3!)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(.banana2)
                        .resizable()
                        .scaledToFill()
                }
                
                if item.uiImage4 != nil {
                    Image(uiImage: item.uiImage4!)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(.banana2)
                        .resizable()
                        .scaledToFill()
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame(height: 260)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            GradePill(grade: grade) // Reusing your existing Atom
                .padding(16)
                .padding(.bottom, 24)
                .allowsHitTesting(false)
        }
    }
}

struct DetailHeaderInfo: View {
    let title: String
    let price: Double
    let stock: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .top) {
                Text(title)
                    .font(.title2.weight(.bold))
                    .foregroundStyle(.primary)
                
                Spacer()
                
                PriceText(price: price) // Reusing your existing Atom
                    .font(.title2.weight(.bold))
            }
            
            HStack(spacing: 4) {
                Text("Stok :")
                    .foregroundStyle(.secondary)
                Text("\(stock)")
                    .foregroundStyle(Color.red)
            }
            .font(.subheadline)
        }
    }
}

struct ExpandableDescription: View {
    let description: String
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Deskripsi")
                .font(.headline)
            
            Text(description)
                .font(.subheadline)
                .foregroundStyle(.primary)
                .lineSpacing(6)
                .lineLimit(isExpanded ? nil : 4)
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isExpanded.toggle()
                }
            }) {
                Text(isExpanded ? "Sembunyikan" : "Baca selengkapnya")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Color.green)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct CountdownBanner: View {
    let timeRemaining: Date
    
    var body: some View {
        HStack {
            Text("Batas maksimal jemput dalam ")
                .font(.subheadline)
                .foregroundStyle(Color.red.opacity(0.8))
            Text(formattedExpiry(timeRemaining))
                .font(.subheadline.weight(.bold))
                .foregroundStyle(Color.red)
            
            Spacer()
            
            // Circular progress indicator
            Circle()
                .stroke(Color.red.opacity(0.3), lineWidth: 2)
                .frame(width: 24, height: 24)
                .overlay(
                    Circle()
                        .trim(from: 0, to: 0.75) // Example progress
                        .stroke(Color.red, lineWidth: 2)
                        .rotationEffect(.degrees(-90))
                )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        // Light red background matching your design
        .background(Color(red: 0.95, green: 0.85, blue: 0.85))
    }

    private func formattedExpiry(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_GB") // 24-hour by default
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        return formatter.string(from: date)
    }
}

struct NoteCard: View {
    let note: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Catatan:")
                .font(.subheadline.weight(.bold))
                .foregroundStyle(.primary)
            Text(note)
                .font(.subheadline)
                .foregroundStyle(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 8, x: 0, y: 4)
    }
}

struct QRActionCard: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Text("Klik QR dan tunjukkan kode kepada penjual\nsaat menjemput barang")
                    .font(.caption.weight(.medium))
                    .foregroundStyle(Color(red: 0.35, green: 0.55, blue: 0.40)) // Brand Green
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Circle()
                    .fill(Color(.systemBackground))
                    .frame(width: 44, height: 44)
                    .overlay(
                        Image(systemName: "qrcode.viewfinder")
                            .font(.system(size: 20))
                            .foregroundStyle(.primary)
                    )
                    .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
            }
            .padding(12)
            .background(Color.green.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.green.opacity(0.3), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

struct SecondaryActionButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundStyle(Color.red)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color(.systemGray4).opacity(0.6))
                .clipShape(Capsule())
        }
    }
}
