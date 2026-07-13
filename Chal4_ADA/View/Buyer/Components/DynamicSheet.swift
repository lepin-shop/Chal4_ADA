//
//  DynamicSheet.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 09/07/26.
//

import Foundation
import SwiftUI

enum SheetMode {
    case checkout
    case qrCode
}

struct DynamicSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    let mode: SheetMode
    let item: Item
    var onConfirm: () -> Void = {}
    
    @State private var note: String = ""
    @State private var quantity: Int = 4
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if mode == .checkout {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(Color(.systemGray))
                            .frame(width: 36, height: 36)
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
                
                Text(mode == .checkout ? "Atur Pesanan" : "Verifikasi Penjemputan")
                    .font(.headline)
                
                Spacer()
                
                // Right Button
                if mode == .checkout {
                    Button(action: {
                        do {
                            let order = try AppContainer.shared.orderService.placeOrder(buyer: SessionManager.shared.currentUser!, item: item, quantity: quantity)
                            
                            try AppContainer.shared.notificationService.notifyIncomingOrder(order)
                            
                            onConfirm()
                        } catch {
                            print("\(error)")
                        }
                    }) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 36, height: 36)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                } else {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(Color(.systemGray))
                            .frame(width: 36, height: 36)
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 12)
            
            Divider()
            
            // MARK: - Dynamic Content
            switch mode {
            case .checkout:
                checkoutContent
            case .qrCode:
                qrCodeContent
            }
        }
    }
    
    private var checkoutContent: some View {
        VStack(spacing: 0) {
            // Product Summary
            HStack(alignment: .top, spacing: 12) {
                if item.imageData1 != nil {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGroupedBackground))
                        .frame(width: 64, height: 64)
                        .overlay(
                            Image(uiImage: item.uiImage1!)
                                .font(.title)
                                .foregroundStyle(Color.red.opacity(0.3))
                        )
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGroupedBackground))
                        .frame(width: 64, height: 64)
                        .overlay(
                            Image(systemName: "photo")
                                .font(.title)
                                .foregroundStyle(Color.red.opacity(0.3))
                        )
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 4) {
                        Image(systemName: "wand.and.stars")
                        Text("Grade \(item.qualityGrade.rawValue)")
                    }
                    .font(.caption.weight(.bold))
                    .foregroundStyle(Color.green)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.green.opacity(0.1))
                    .clipShape(Capsule())
                    
                    Text(item.title)
                        .font(.subheadline.weight(.semibold))
                    
                    Text(formattedPrice(item.pricePerUnit))
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(Color.red)
                }
                Spacer()
            }
            .padding(16)
            
            Divider()
            
            Text("Atur waktu penjemputanmu, pastikan jemput barangnya sebelum waktu maksimal yang diatur penjual. Lokasi Jemput tidak bisa diubah, ya!")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
            
            Divider()
            
            TextField("Note untuk penjual (Opsional)", text: $note)
                .font(.subheadline)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(Color(.systemGray6))
                .clipShape(Capsule())
                .padding(16)
            
            Divider()

            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total Pesanan:")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Text(formattedPrice(item.pricePerUnit * Double(quantity)))
                        .font(.title2.weight(.bold))
                        .foregroundStyle(Color.red)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 8) {
                    Text("Jumlah: \(quantity)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    HStack(spacing: 16) {
                        Button(action: { if quantity > 1 { quantity -= 1 } }) {
                            Image(systemName: "minus")
                                .font(.system(size: 16, weight: .bold))
                        }
                        Divider().frame(height: 20)
                        Button(action: { quantity += 1 }) {
                            Image(systemName: "plus")
                                .font(.system(size: 16, weight: .bold))
                        }
                    }
                    .foregroundStyle(.primary)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .clipShape(Capsule())
                }
            }
            .padding(16)
            
            Spacer()
        }
    }
    
    private var qrCodeContent: some View {
        VStack(spacing: 0) {
            // Instruction Banner
            Text("Tunjukkan dan minta penjual scan kode QR dibawah untuk verifikasi penjemputan dan menyelesaikan pesanan.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(Color.green.opacity(0.1)) // Very light green background
            
            Divider()
            
            Spacer()
            
            // Simulated QR Code with Dashed Border
            ZStack {
                Image(systemName: "qrcode")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .padding(32)
                
                // Dashed overlay matching your design
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [15, 10]))
                    .frame(width: 244, height: 244)
                    .foregroundStyle(Color(.systemGray3))
            }
            
            Spacer()
        }
    }
    
    private func formattedPrice(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 0
        let value = formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
        return "Rp. \(value)"
    }
}
