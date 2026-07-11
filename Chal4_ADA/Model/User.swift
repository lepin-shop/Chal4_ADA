//
//  User.swift
//  Chal4_ADA
//
//  Created by Danniel on 02/07/26.
//
import Foundation
import SwiftData

@Model
final class User {
    @Attribute(.unique) var id: UUID
    var name: String
    var phone: String
    var location: String
    var createdAt: Date
    var email: String
    
    @Relationship(deleteRule: .cascade, inverse: \Item.seller)
    var items: [Item] = []

    @Relationship(deleteRule: .cascade, inverse: \Order.buyer)
    var orders: [Order] = []

    @Relationship(deleteRule: .cascade, inverse: \Follow.requester)
    var sentFollows: [Follow] = []

    @Relationship(deleteRule: .cascade, inverse: \Follow.target)
    var receivedFollows: [Follow] = []

    var following: [User] {
        sentFollows.filter { $0.status == .accepted }.map { $0.target }
    }

    var followers: [User] {
        receivedFollows.filter { $0.status == .accepted }.map { $0.requester }
    }

    var pendingIncomingRequests: [Follow] {
        receivedFollows.filter { $0.status == .pending }
    }

    var pendingOutgoingRequests: [Follow] {
        sentFollows.filter { $0.status == .pending }
    }

    init(
        id: UUID = UUID(),
        name: String,
        phone: String,
        location: String,
        createdAt: Date = Date(),
        email: String
    ) {
        self.id = id
        self.name = name
        self.phone = phone
        self.location = location
        self.createdAt = createdAt
        self.email = email
    }
}
