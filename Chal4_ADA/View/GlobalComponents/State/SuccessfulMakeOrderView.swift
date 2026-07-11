//
//  SuccessfulMakeOrder.swift
//  Chal4_ADA
//
//  Created by Danniel on 12/07/26.
//

import SwiftUI

struct SuccessfulMakeOrderView: View {
    var body: some View {
        VStack (spacing: 0) {
            Image(.successMakeOrder)
                .padding(.bottom, 40)
            
            Text("Pesanan diterima")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.bottom, 6)
            
            Text("Silakan menuju lokasi penjemputan untuk menyelesaikan transaksi")
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundStyle(.neutralm2)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    SuccessfulMakeOrderView()
}
