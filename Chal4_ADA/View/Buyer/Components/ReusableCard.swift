//
//  ReusableCard.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 11/07/26.
//

import Foundation
import SwiftUI

struct GradePill: View {
    let grade: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "wand.and.stars")
                .font(.system(size: 10, weight: .bold))
            Text("Grade \(grade)")
                .font(.caption2.weight(.bold))
        }
        .foregroundStyle(Color.green)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color(.systemBackground).opacity(0.95))
        .clipShape(Capsule())
    }
}

struct PriceText: View {
    let price: Double
    
    var body: some View {
        Text(formattedPrice(price))
            .font(.subheadline.weight(.bold))
            .foregroundStyle(Color.red)
    }
    
    private func formattedPrice(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        let value = formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
        return "Rp. \(value)"
    }
}

struct FulfillmentStatusView: View {
    let statusText: Date
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "box.truck.fill") // iOS 17+ or use "shippingbox.fill"
                .font(.caption2)
            Text(formattedExpiry(statusText))
                .font(.caption2.weight(.medium))
                .lineLimit(1)
        }
        .foregroundStyle(Color.orange)
    }
    private func formattedExpiry(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_GB") // 24-hour by default
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        return formatter.string(from: date)
    }
}

struct ProductGridThumbnail: View {
    let imageName: String
    let grade: String
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .fill(Color.clear)
                .aspectRatio(1.2, contentMode: .fit)
                .overlay(
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                )
                .clipped()
            
            GradePill(grade: grade)
                .padding(8)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct SellerCompactRow: View {
    let sellerName: String
    
    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(Color(.systemGray3))
                .frame(width: 20, height: 20)
                .overlay(Image(systemName: "person.fill").font(.system(size: 10)).foregroundStyle(.white))
            
            Text(sellerName)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
    }
}

// Product Grid on Buyer Screen

struct ProductGridCard: View {
    let item: Item
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ProductGridThumbnail(imageName: item.mediaUrl, grade: item.qualityGrade.rawValue)
            
            VStack(alignment: .leading, spacing: 4) {
                SellerCompactRow(sellerName: item.seller.name)
                
                Text(item.title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                
                PriceText(price: item.pricePerUnit)
                
                FulfillmentStatusView(statusText: item.expiresAt)
            }
            .padding(.horizontal, 4)
            .padding(.bottom, 8)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// List Card yang di segment
struct CartListCard: View {
    let imageName: String
    let grade: String
    let title: String
    let stock: Int
    let price: Double
    let expiryDate: Date
    
    var body: some View {
        HStack(spacing: 16) {
            ProductGridThumbnail(imageName: imageName, grade: grade)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                    .lineLimit(1)
                
                Text("Stok: \(stock)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
        
                PriceText(price: price)
                
                FulfillmentStatusView(statusText: expiryDate)
            }
            
            Spacer(minLength: 0)
        }
        .padding(12)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 8, x: 0, y: 4)
    }
}

// Card yang di .myOrder segment

struct OrderSummaryCard: View {
    let item: Item
    let quantityBought: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Seller Info Tier
            HStack(spacing: 12) {
                Circle()
                    .fill(Color(.systemGray4))
                    .frame(width: 36, height: 36)
                    .overlay(Image(systemName: "person.fill").foregroundStyle(.white))
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(item.seller.name).font(.subheadline.weight(.semibold))
                    HStack(spacing: 4) {
                        Image(systemName: "mappin.circle.fill").foregroundStyle(Color(.systemGray3))
                        Text(item.seller.location)
                            .font(.caption2).foregroundStyle(.secondary).lineLimit(1)
                    }
                }
            }
            
            Divider()
            
            // Product Info Tier
            HStack(alignment: .top, spacing: 12) {
                ProductGridThumbnail(imageName: item.mediaUrl, grade: String(describing: item.qualityGrade))
                    .frame(width: 80, height: 80)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(item.title).font(.headline).lineLimit(1)
                    
                    Spacer()
                    
                    HStack {
                        Text("Harga satuan").font(.caption).foregroundStyle(.primary)
                        Spacer()
                        Text("Rp. \(item.pricePerUnit, specifier: "%.0f")").font(.caption.weight(.medium)).foregroundStyle(Color.red)
                    }
                    
                    HStack {
                        Text("Total beli: \(quantityBought)").font(.caption).foregroundStyle(.primary)
                        Spacer()
                        Text("Rp. \(item.pricePerUnit * Double(quantityBought), specifier: "%.0f")").font(.body.weight(.bold)).foregroundStyle(Color.red)
                    }
                }
                .frame(height: 80)
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 8, x: 0, y: 4)
    }
}
