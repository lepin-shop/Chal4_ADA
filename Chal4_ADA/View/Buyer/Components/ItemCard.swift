//
//  ItemCard.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 03/07/26.
//

import Foundation
import SwiftUI

struct ItemCard: View {
    let item: Item
    
    var buttonText: String = "Order"
    var buttonColor: Color = .blue
    var grade: String = "-"
    var quantity: Int = 0
    var price: Double = 0
    var onButtonTapped: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            
            // Top: image + info
            HStack(alignment: .top, spacing: 16) {
                
                // Image
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color(.systemGroupedBackground))
                        .frame(width: 120, height: 120)
                    
                    if item.imageData1 != nil {
                        Image(uiImage: item.uiImage1!)
                            .font(.system(size: 40))
                            .foregroundStyle(Color.accentColor)
                    } else {
                        Image(systemName: "photo")
                            .font(.system(size: 40))
                            .foregroundStyle(Color.accentColor)
                    }
                }
                
                // Info
                VStack(alignment: .leading, spacing: 6) {
                    
                    // Seller name
                    HStack(spacing: 4) {
                        Image(systemName: "person.circle")
                            .font(.caption)
                        Text(item.seller.name)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    // Item title
                    Text(item.title)
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.primary)
                    
                    // Grade + quantity
                    HStack(spacing: 8) {
                        Text("Grade: \(grade)")
                            .font(.caption2)
                        Text("Qty: \(quantity)")
                            .font(.caption2)
                    }
                    .foregroundStyle(.secondary)
                    
                    // Price
                    Text(formattedPrice(price))
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.primary)
                }
                
                Spacer()
            }
            .padding(.horizontal, 8)
            
            // Bottom: action buttons
            HStack(spacing: 32) {
                VStack(spacing: 6){
                    HStack(spacing: 8) {
                        Image(systemName: "storefront")
                        Text(item.seller.location)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    HStack(spacing: 8) {
                        Image(systemName: "timer")
                            .foregroundStyle(Color.orange)
                        Text("Pickup Now before \(formattedExpiry(item.expiresAt))")
                            .foregroundStyle(.orange)
                        Spacer()
                    }
                }
                .font(.caption2)
                
                // The customizable button
                Button(action: {
                    onButtonTapped()
                }) {
                    Text(buttonText)
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(buttonColor)
                        .clipShape(Capsule())
                }
            }
            .buttonStyle(.plain)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    /// HELPER
    
    private func formattedPrice(_ item: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 0
        let value = formatter.string(from: NSNumber(value: price)) ?? "\(price)"
        
        return "Rp\(value)"
    }
    private func formattedExpiry(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_GB") // 24-hour by default
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        return formatter.string(from: date)
    }
}
