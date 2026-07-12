//
//  Notification 2.swift
//  Chal4_ADA
//
//  Created by Danniel on 12/07/26.
//

import Foundation
import SwiftData

@Model
final class Notification {
    @Attribute(.unique) var id: UUID
    var user: User?
    var type: NotificationType
    var timestamp: Date
    var message: String
    
    // Order or Follow id related
    var relatedID: UUID?

    init(
        id: UUID = UUID(),
        message: String,
        type: NotificationType,
        relatedID: UUID? = nil,
        timestamp: Date = .now
    ) {
        self.id = id
        self.message = message
        self.timestamp = timestamp
        self.type = type
        self.relatedID = relatedID
    }
}
