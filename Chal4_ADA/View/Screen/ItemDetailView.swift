//
//  ItemDetailView.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 03/07/26.
//

import Foundation
import SwiftUI


struct ItemDetailView: View {
    let item: Item
    
    var primaryButtonText: String = "Lanjut Pembelian"
    var buttonTextColor: Color = .white
    var buttonBackgroundColor: Color = Color.green.opacity(0.85)
    var onPrimaryAction: ((Int, Double)) -> Void = { _ in }
    
    @State private var quantity: Int = 1
    @State private var isDescriptionExpanded: Bool = false
    
    
    private var totalBayar: Double {
        NSDecimalNumber(decimal: Decimal(item.pricePerUnit)).doubleValue * Double(quantity)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 8) {
                    Image(systemName: "mappin.and.ellipse.circle.fill")
                        .foregroundStyle(Color(.systemGray))
                    Text(item.seller.location)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                
                // 2. Main Product Image
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemGroupedBackground))
                        .frame(height: 240)
                    
                    Image(systemName: item.mediaUrl)
                        .font(.system(size: 80))
                        .foregroundStyle(Color.red.opacity(0.3))
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                
                // 3. Pickup Time
                HStack(spacing: 8) {
                    Image(systemName: "clock.fill")
                    Text("Ambil Sebelum: \(ItemDetailView.formatExpiry(item.expiresAt))")
                }
                .font(.subheadline.weight(.medium))
                .foregroundStyle(Color.orange)
                .padding(.horizontal, 16)
                .padding(.top, 24)
                
                Divider().padding(.vertical, 16).padding(.horizontal, 16)
                
                // 4. Product Info
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Grade \(String(describing: item.qualityGrade))")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Color.green)
                        
                        Text(item.title)
                            .font(.title2.weight(.bold))
                            .foregroundStyle(.primary)
                        
                        Text("Stok : \(item.quantity)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Text(formattedPrice(item.pricePerUnit))
                        .font(.title3.weight(.bold))
                        .foregroundStyle(Color.red)
                }
                .padding(.horizontal, 16)
                
                Divider().padding(.vertical, 16).padding(.horizontal, 16)
                
                // 5. Seller Info
                HStack(spacing: 12) {
                    Circle()
                        .fill(Color(.systemGray4))
                        .frame(width: 40, height: 40)
                        .overlay(Image(systemName: "person.fill").foregroundStyle(.white))
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(item.seller.name)
                            .font(.subheadline.weight(.semibold))
                        Text(item.seller.phone)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.horizontal, 16)
                
                Divider().padding(.vertical, 16).padding(.horizontal, 16)
                
                // 6. Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("Deskripsi")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.description)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .lineSpacing(4)
                            .lineLimit(isDescriptionExpanded ? nil : 1)
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isDescriptionExpanded.toggle()
                            }
                        }) {
                            Text(isDescriptionExpanded ? "Sembunyikan" : "Baca selengkapnya")
                                .font(.subheadline.weight(.medium))
                                .foregroundStyle(Color.green)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }
        }
        
        .safeAreaInset(edge: .bottom) {
            
            VStack(spacing: 16) {
                HStack(alignment: .bottom) {
                    // Total Price
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Total Bayar:")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(formattedPrice(totalBayar))
                            .font(.title3.weight(.bold))
                            .foregroundStyle(Color.red)
                    }
                    
                    Spacer()
                    
                    // Custom Stepper
                    VStack(alignment: .trailing, spacing: 8) {
                        Text("Jumlah: \(quantity)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        HStack(spacing: 16) {
                            Button(action: {
                                if quantity > 1 { quantity -= 1 }
                            }) {
                                Image(systemName: "minus")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(.primary)
                            }
                            
                            Divider().frame(height: 20)
                            
                            Button(action: {
                                if quantity < item.quantity { quantity += 1 }
                            }) {
                                Image(systemName: "plus")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(.primary)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray6))
                        .clipShape(Capsule())
                    }
                }
                
                // Action Button
                Button(action: {
                    onPrimaryAction((quantity, totalBayar))
                }) {
                    Text(primaryButtonText)
                        .font(.headline)
                        .foregroundStyle(buttonTextColor)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(buttonBackgroundColor)
                        .clipShape(Capsule())
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 8)
            .background(
                Color(.systemBackground)
                    .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: -5)
                    .ignoresSafeArea(edges: .bottom)
            )
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Detail Produk")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Helpers
    private func formattedPrice(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 0
        let value = formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
        return "Rp. \(value)"
    }
    private static func formatExpiry(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.dateFormat = "HH.mm, d MMM yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    NavigationStack {
        let sampleItem = ItemsData.activeItems[0]
        
        ItemDetailView(
            item: sampleItem,
            primaryButtonText: "Lanjut Pembelian",
            onPrimaryAction: { quantity, total in
                print("Checkout tapped! Qty: \(quantity) | Total: Rp. \(total)")
            }
        )
    }
}



