//
//  NotificationError.swift
//  Chal4_ADA
//
//  Created by Danniel on 12/07/26.
//
import Foundation

enum NotificationError: LocalizedError {
    case notificationNotFound

    var errorDescription: String? {
        switch self {
        case .notificationNotFound:
            return "Notifikasi terkait tidak ditemukan."
        }
    }
}
