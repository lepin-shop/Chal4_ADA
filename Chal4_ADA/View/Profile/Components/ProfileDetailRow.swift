//
//  DetailRow.swift
//  Chal4_ADA
//
//  Created by Danniel on 11/07/26.
//

import SwiftUI

struct ProfileDetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 16))
                .foregroundColor(.black)
            Spacer()
            Text(value)
                .font(.system(size: 16))
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
    }
}
