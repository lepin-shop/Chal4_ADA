//
//  CartScreen.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 11/07/26.
//

import SwiftUI

struct CartScreen: View {
    var body: some View {
        VStack(spacing: 16) {
            ScrollView {
                LazyVStack(spacing: 16) {
                    OrderPageSection()
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }
        }
        .background(Color(.systemGray6).ignoresSafeArea())
        .navigationTitle("Riwayat Pembelian")
        .navigationBarTitleDisplayMode(.inline)
    }
}
