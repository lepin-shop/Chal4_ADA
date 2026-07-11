//
//  NoItemView.swift
//  Chal4_ADA
//
//  Created by Danniel on 12/07/26.
//

import SwiftUI

struct NoItemView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(.noItemToSee)
                .padding(.bottom, 40)
            
            Text("Belum ada produk")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.bottom, 8)
            
            Text("belum ada mitra yang posting produk untuk kamu")
                .font(.footnote)
                .foregroundStyle(.neutral)
        }
    }
}

#Preview {
    NoItemView()
}
