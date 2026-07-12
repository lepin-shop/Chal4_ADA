//
//  NotificationRow.swift
//  Chal4_ADA
//
//  Created by Danniel on 12/07/26.
//
import SwiftUI

struct NotificationRow: View {
    let notification: Notification
    let onPrimaryAction: () -> Void
    
    var body: some View {
        HStack(spacing: 14) {
            iconView
            
            VStack(alignment: .leading, spacing: 4) {
                Text(notification.message)
                    .font(.body.weight(.medium))
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(notification.timestamp, format: .dateTime.hour().minute())
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer(minLength: 8)
            
//            if let actionLabel {
//                Button(actionLabel, action: onPrimaryAction)
//                    .buttonStyle(.borderedProminent)
//                    .tint(.green)
//            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
    }
    
    private var iconView: some View {
        Circle()
            .fill(Color.green.opacity(0.15))
            .frame(width: 52, height: 52)
            .overlay {
                Image(systemName: iconName)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.green)
            }
    }
    
    private var iconName: String {
        switch notification.type {
        case .incomingOrder(let isCompleted): isCompleted ? "checkmark" : "cart.badge.plus"
        case .followRequest(let isAccepted): isAccepted ? "checkmark" : "person.badge.plus"
        }
    }
    
    private var actionLabel: String? {
        switch notification.type {
        case .incomingOrder(let isCompleted): isCompleted ? nil : "Lihat Pesanan"
        case .followRequest(let isAccepted): isAccepted ? nil : "Terima"
        }
    }
}
