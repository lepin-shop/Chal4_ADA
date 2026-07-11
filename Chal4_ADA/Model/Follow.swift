//
//  Follow.swift
//  Chal4_ADA
//
//  Created by Danniel on 10/07/26.
//

import Foundation
import SwiftData

@Model
final class Follow {
    @Attribute(.unique) var id: UUID
    var requester: User
    var target: User
    var status: FollowStatus
    var createdAt: Date
    var respondedAt: Date?

    #Unique<Follow>([\.requester, \.target])

    init(
        id: UUID = UUID(),
        requester: User,
        target: User,
        status: FollowStatus = .pending,
        createdAt: Date = Date(),
        respondedAt: Date? = nil
    ) {
        self.id = id
        self.requester = requester
        self.target = target
        self.status = status
        self.createdAt = createdAt
        self.respondedAt = respondedAt
    }
}
