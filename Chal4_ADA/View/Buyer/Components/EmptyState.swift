//
//  EmptyState.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 08/07/26.
//

import Foundation
import SwiftUI

struct EmptyState: View {
    var icon: String
    var message: String
    var iconColor: Color = .gray
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundStyle(iconColor)
            
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 40)
        .frame(maxWidth: .infinity)
    }
}
