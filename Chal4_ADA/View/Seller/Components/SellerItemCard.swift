//
//  SellerItemCard.swift
//  Chal4_ADA
//
//  Created by Filipus Darren Siswanto on 11/07/26.
//

import SwiftUI

struct SellerItemCard: View {
    var item: Item
    
    var body: some View {
        HStack(spacing: 14) {
            ZStack(alignment: .bottom) {
                if item.uiImage1 != nil {
                    Image(uiImage: item.uiImage1!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 96, height: 96)
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                } else {
                    Image(.banana)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 96, height: 96)
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                }
                
                HStack(spacing: 3) {
                    Image(systemName: "wand.and.stars")
                    Text(item.qualityGrade.rawValue)
                }
                .font(.caption2.weight(.semibold))
                .foregroundStyle(.accents)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(.white, in: Capsule())
                .padding(.bottom, 6)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.title3.bold())
                    .foregroundStyle(.primary)

                Text("Stok: \(item.quantityAvailable)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text("Rp. \(String(format: "%.0f", item.pricePerUnit))")
                    .font(.title3.bold())
                    .foregroundStyle(.destructive)

                HStack(spacing: 4) {
                    Image(systemName: "box.truck.fill")
                    Text("Batas ambil maks. 20.00")
                }
                .font(.caption.weight(.medium))
                .foregroundStyle(Color("PickupGold"))
                .padding(.top, 2)
            }

            Spacer()
        }
        .padding(12)
        .background(.white, in: RoundedRectangle(cornerRadius: 24))
    }
}
