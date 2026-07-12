//
//  EmptyGoodsScreen.swift
//  Chal4_ADA
//
//  Created by Filipus Darren Siswanto on 11/07/26.
//

import SwiftUI
import SwiftData

struct EmptyGoodsScreen: View {
    var onSell: () -> Void = {}

    @Query var items: [Item]
    
    var hasGoods: Bool {
        return !items.isEmpty
    }

    var body: some View {
            ZStack(alignment: .top) {
                LinearGradient(
                    colors: [.accent1, .bannerGreenEnd],
                    startPoint: UnitPoint(x: 0.35, y: 0.0),  // Mulai dari atas agak ke kanan sedikit
                    endPoint: UnitPoint(x: 0.85, y: 1.0)
                )
                .frame(height: 155)
                .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 40, bottomTrailingRadius: 40))
                .ignoresSafeArea(edges: .top)

                VStack(spacing: 0) {
                    headerCard

                    if hasGoods {
                        ScrollView {
                            SellerGoodsList()
                                .padding(.horizontal, 16)
                                .padding(.top, 20)
                        }
                    } else {
                        Spacer()

                        EmptyGoodsState()

                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(Color(.systemGroupedBackground))
        }
        
        // MARK: - Header (White Card & Green Tip)
        
    private var headerCard: some View {
        ZStack(alignment: .top) {
            // B. Green Card
            VStack(spacing: 0) {
                Spacer().frame(height: 86)

                HStack(alignment: .center, spacing: 2) {
                    Image(systemName: "lightbulb.max.fill")
                        .font(.system(size: 13))
                        .offset(y: -3)
                    Text("Jual buah sekarang kalau sudah terlalu matang untuk besok")
                        .font(.caption2)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .foregroundStyle(.black.opacity(0.8))
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.green.opacity(0.18))
                .clipShape(RoundedRectangle(cornerRadius: 24))
            }
            .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 4)

            // White Card
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 6) {
                        Image(systemName: "storefront.fill")
                            .font(.caption)
                            .foregroundStyle(.white)
                            .frame(width: 20, height: 20)
                            .background(Circle().fill(Color.black))

                        Text("Toko Buah Budi")
                            .fontWeight(.semibold)
                    }
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Capsule().fill(Color.green.opacity(0.12)))

                    HStack(spacing: 3) {
                        Image(systemName: "list.clipboard.fill")
                        Text(hasGoods ? "3 dijual | 1 dipesan" : "0 dijual | 0 dipesan")
                    }
                    .font(.caption.weight(.medium))
                    .foregroundStyle(Color.mutedGold)
                    .padding(.leading, 10)
                }

                Spacer()

                Button(action: onSell) {
                    Label("Jual", systemImage: "plus")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Color.accents, in: Capsule())
                }
            }
            .padding(16)
            .background(.white)
            .clipShape(UnevenRoundedRectangle(topLeadingRadius: 24, bottomLeadingRadius: 24, bottomTrailingRadius: 24, topTrailingRadius: 24))
        }
        .padding(.horizontal, 16)
        .padding(.top, 20)
    }
}
