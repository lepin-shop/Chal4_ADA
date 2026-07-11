//
//  NoNotificationView.swift
//  Chal4_ADA
//
//  Created by Danniel on 12/07/26.
//

import SwiftUI

struct NoNotificationView: View {
    var body: some View {
        VStack (spacing: 40) {
            Image(.noNotification)
            
            Text("Belum ada notifikasi")
                .font(.title3)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    NoNotificationView()
}
