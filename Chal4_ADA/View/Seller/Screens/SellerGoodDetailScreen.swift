//
//  SellerGoodDetailScreen.swift
//  Chal4_ADA
//
//  Created by Filipus Darren Siswanto on 12/07/26.
//

import SwiftUI

struct SellerGoodDetailScreen: View {
    let item: Item

    @ObservedObject private var router = AppRouter.shared

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                productImage

                pageDots

                HStack(spacing: 4) {
                    Image(systemName: "box.truck.fill")
                    Text("Jemput sebelum 20.00")
                }
                .font(.subheadline.weight(.medium))
                .foregroundStyle(Color("PickupGold"))

                Divider()

                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.title)
                            .font(.title2.bold())
                            .foregroundStyle(.primary)

                        Text("Stok: \(item.quantityAvailable)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 2) {
                        Text("Harga satuan")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        Text("Rp. \(String(format: "%.0f", item.pricePerUnit))")
                            .font(.title2.bold())
                            .foregroundStyle(.destructive)
                    }
                }

                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Deskripsi")
                        .font(.headline)
                        .foregroundStyle(.primary)

                    Text(item.itemDescription)
                        .font(.body)
                        .foregroundStyle(.primary)
                }

                Spacer(minLength: 8)

                deleteButton
            }
            .padding(20)
        }
        .background(Color.background)
        .navigationTitle("Detail Dagangan")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // TODO: aksi edit dagangan
                } label: {
                    Image(systemName: "square.and.pencil")
                }
                .tint(.primary)
            }
        }
    }

    // MARK: - Subviews

    private var productImage: some View {
        ZStack(alignment: .bottomLeading) {
            if item.uiImage1 != nil {
                Image(uiImage: item.uiImage1!)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 20))

            } else {
                Image(.banana)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            HStack(spacing: 3) {
                Image(systemName: "wand.and.stars")
                Text(item.qualityGrade.rawValue)
            }
            .font(.caption.weight(.semibold))
            .foregroundStyle(.accents)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(.white, in: Capsule())
            .padding(12)
        }
    }

    private var pageDots: some View {
        HStack(spacing: 8) {
            ForEach(0..<4, id: \.self) { index in
                Circle()
                    .fill(index == 0 ? Color.accents : Color(.systemGray4))
                    .frame(width: 7, height: 7)
            }
        }
        .frame(maxWidth: .infinity)
    }

    private var deleteButton: some View {
        Button {
            // TODO: hapus dagangan dari sumber data
            router.pop()
        } label: {
            Text("Hapus dagangan")
                .font(.headline)
                .foregroundStyle(.destructive)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.destructive.opacity(0.12), in: RoundedRectangle(cornerRadius: 24))
        }
    }
}
