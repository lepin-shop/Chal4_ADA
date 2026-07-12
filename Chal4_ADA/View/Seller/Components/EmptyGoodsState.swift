//
//  EmptyGoodsState.swift
//  Chal4_ADA
//
//  Created by Filipus Darren Siswanto on 11/07/26.
//

import SwiftUI

struct EmptyGoodsState: View {
    var title: String = "Belum ada transaksi"
    var message: String = "Tambah (+) jualanmu dan selamatkan stok yang berlebih"

    var body: some View {
        VStack(spacing: 16) {
            Image(.emptyTransactionView)
                .resizable()
                .scaledToFit()
                .frame(width: 220, height: 220)

            Text(title)
                .font(.title2.bold())
                .foregroundStyle(.primary)

            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
}

#Preview {
    EmptyGoodsState()
}
