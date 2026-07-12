//
//  FollowError.swift
//  Chal4_ADA
//
//  Created by Danniel on 11/07/26.
//

import Foundation

enum FollowError: Error {
    case cannotFollowSelf
    case requestAlreadyExists
    case followNotFound
    case notPending
    
    var errorDescription: String? {
        switch self {
        case .cannotFollowSelf:
            return "Anda tidak dapat mengikuti diri anda."
        case .requestAlreadyExists:
            return "Ajakan mengikuti sudah ada."
        case .followNotFound:
            return "Ajakan tidak ditemukan."
        case .notPending:
            return "Ajakan ini sudah diterima."
        }
    }
}
