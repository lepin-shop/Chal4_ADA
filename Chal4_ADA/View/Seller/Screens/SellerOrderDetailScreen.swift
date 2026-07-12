//
//  SellerOrderDetailScreen.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 12/07/26.
//

import SwiftUI

struct SellerOrderDetailScreen: View {

    @State private var showQRScanner = false
    
    // Dummy Data for the view based on your mockup
    let productName: String = "Semangka Swedia"
    let unitPrice: Double = 8000
    let quantity: Int = 4
    let buyerName: String = "Toko buah bayazir Kemang"
    let buyerPhone: String = "08929596979821"
    let orderNote: String = "yang ambil temenku cici-cirinya botak tinggi kurus"
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Main Background
            Color(.systemGray6).ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                countdownBanner
                
                ScrollView {
                    VStack(spacing: 16) {
                        
                        // 3. Product Information Card
                        productCard
                        
                        // 4. Buyer Info & Notes Card
                        buyerAndNoteCard
                        
                    }
                    .padding(16)
                    .padding(.bottom, 100) // Safe padding for the sticky bottom button
                }
            }
            
            // 5. Sticky Bottom Action Bar
            bottomActionBar
        }
        .navigationTitle("Detail pesanan")
        .fullScreenCover(isPresented: $showQRScanner) {
            QRScannerScreen()
        }
    }
    
    // MARK: - View Components
    
    
    private var countdownBanner: some View {
        HStack {
            Text("Batas maksimal jemput dalam ")
                .font(.subheadline)
                .foregroundStyle(Color.red.opacity(0.8))
            Text("02:58:02")
                .font(.subheadline.weight(.bold))
                .foregroundStyle(Color.red)
            
            Spacer()
            
            // Circular progress indicator
            Circle()
                .stroke(Color.red.opacity(0.3), lineWidth: 2)
                .frame(width: 24, height: 24)
                .overlay(
                    Circle()
                        .trim(from: 0, to: 0.8)
                        .stroke(Color.red, lineWidth: 2)
                        .rotationEffect(.degrees(-90))
                )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color(red: 0.95, green: 0.85, blue: 0.85)) // Light red background
    }
    
    private var productCard: some View {
        HStack(alignment: .top, spacing: 16) {
            ZStack(alignment: .bottomLeading) {
                // Placeholder rectangle for the image
                Rectangle()
                    .fill(Color(.systemGray4))
                    .frame(width: 90, height: 90)
                    .overlay(
                        Image("semangka") // Replace with actual image asset
                            .resizable()
                            .scaledToFill()
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // Inline Grade Pill
                HStack(spacing: 4) {
                    Image(systemName: "wand.and.stars")
                        .font(.system(size: 10, weight: .bold))
                    Text("Grade B")
                        .font(.caption2.weight(.bold))
                }
                .foregroundStyle(Color.green)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color(.systemBackground).opacity(0.95))
                .clipShape(Capsule())
                .padding(6)
            }
            
            // Right Side: Product Details
            VStack(alignment: .leading, spacing: 8) {
                Text(productName)
                    .font(.title3.weight(.bold))
                    .lineLimit(1)
                
                Spacer()
                
                HStack {
                    Text("Harga satuan")
                        .font(.subheadline)
                        .foregroundStyle(.primary)
                    Spacer()
                    Text("Rp. \(unitPrice, specifier: "%.0f")")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(Color.red)
                }
                
                HStack {
                    Text("Total beli: \(quantity)")
                        .font(.subheadline)
                        .foregroundStyle(.primary)
                    Spacer()
                    Text("Rp. \(unitPrice * Double(quantity), specifier: "%.0f")")
                        .font(.body.weight(.bold))
                        .foregroundStyle(Color.red)
                }
            }
            .frame(height: 90)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 8, x: 0, y: 4)
    }
    
    private var buyerAndNoteCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Top Tier: Buyer Info
            HStack(spacing: 12) {
                Circle()
                    .fill(Color(.systemGray4))
                    .frame(width: 40, height: 40)
                    // Replace with actual buyer avatar if available
                    .overlay(Image(systemName: "person.fill").foregroundStyle(.white))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(buyerName)
                        .font(.subheadline.weight(.semibold))
                    Text(buyerPhone)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Text("Pemesan")
                    .font(.caption)
                    .foregroundStyle(Color.green)
            }
            
            Divider()
            
            // Bottom Tier: Notes
            VStack(alignment: .leading, spacing: 4) {
                Text("Catatan:")
                    .font(.subheadline.weight(.bold))
                Text(orderNote)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 8, x: 0, y: 4)
    }
    
    private var bottomActionBar: some View {
        VStack {
            Button(action: {
                showQRScanner = true
            }) {
                Text("Selesaikan pemesanan")
                    .font(.headline)
                    .foregroundStyle(Color(red: 0.35, green: 0.65, blue: 0.45)) // Green text
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color(.systemGray5)) // Gray pill background
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 8)
        }
        .background(
            Color(.systemGray6)
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: -5)
                .ignoresSafeArea(edges: .bottom)
        )
    }
}
#Preview {
    SellerOrderDetailScreen()
}
