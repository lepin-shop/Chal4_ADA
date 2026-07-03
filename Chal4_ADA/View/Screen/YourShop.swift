//
//  YourShop.swift
//  Chal4_ADA
//
//  Created by Danniel on 03/07/26.
//

import SwiftUI

struct YourShop: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Banner()
            .padding(.bottom, 24)
           
            YourPostsSection()
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 28)
    }
}

#Preview {
    RouterPage()
}

