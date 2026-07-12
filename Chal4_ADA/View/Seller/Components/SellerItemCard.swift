//
//  SellerItemCard.swift
//  Chal4_ADA
//
//  Created by Filipus Darren Siswanto on 11/07/26.
//

import SwiftUI

struct SellerItemCard: View {
    let image: ImageResource
    let grade: String
    let title: String
    let stock: Int
    let price: String
    let pickupLimit: String

    var body: some View {
        HStack(spacing: 14) {
            ZStack(alignment: .bottom) {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 96, height: 96)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                HStack(spacing: 3) {
                    Image(systemName: "wand.and.stars")
                    Text(grade)
                }
                .font(.caption2.weight(.semibold))
                .foregroundStyle(.accents)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(.white, in: Capsule())
                .padding(.bottom, 6)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title3.bold())
                    .foregroundStyle(.primary)

                Text("Stok: \(stock)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(price)
                    .font(.title3.bold())
                    .foregroundStyle(.destructive)

                HStack(spacing: 4) {
                    Image(systemName: "box.truck.fill")
                    Text(pickupLimit)
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

#Preview {
    SellerItemCard(
        image: .banana,
        grade: "Grade B",
        title: "Pisang Ripe",
        stock: 4,
        price: "Rp. 5.000",
        pickupLimit: "Batas ambil maks. 20.00"
    )
    .padding()
    .background(Color(.systemGroupedBackground))
}
