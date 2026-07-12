//
//  NotificationError.swift
//  Chal4_ADA
//
//  Created by Danniel on 12/07/26.
//


//
//  NotificationService.swift
//  Chal4_ADA
//

import Foundation
import SwiftData

final class NotificationService {
    private let repository: NotificationRepository

    init(repository: NotificationRepository) {
        self.repository = repository
    }

    func fetch(forUser user: User) throws -> [Notification] {
        try repository.fetch(forUser: user.id)
    }

    func delete(_ notification: Notification) throws {
        repository.delete(notification)
        try repository.save()
    }

    @discardableResult
    func notifyIncomingOrder(_ order: Order) throws -> Notification {
        let notification = Notification(
            message: "\(order.buyer.name) memesan \(order.item.title)",
            type: .incomingOrder(isCompleted: false),
            relatedID: order.id
        )
        notification.user = order.item.seller
        repository.insert(notification)
        try repository.save()
        return notification
    }

    func markOrderCompleted(_ order: Order) throws {
        guard let notification = try repository.fetch(byRelatedID: order.id, forUser: order.item.seller.id) else {
            throw NotificationError.notificationNotFound
        }
        notification.type = .incomingOrder(isCompleted: true)
        try repository.save()
    }
    
    @discardableResult
    func notifyFollowRequest(_ follow: Follow) throws -> Notification {
        let notification = Notification(
            message: "\(follow.requester.name) ingin mengikuti anda",
            type: .followRequest(isAccepted: false),
            relatedID: follow.id
        )
        notification.user = follow.target
        repository.insert(notification)
        try repository.save()
        return notification
    }

    func markFollowRequestAccepted(_ follow: Follow) throws {
        guard let notification = try repository.fetch(byRelatedID: follow.id, forUser: follow.target.id) else {
            throw NotificationError.notificationNotFound
        }
        notification.type = .followRequest(isAccepted: true)
        try repository.save()
    }

    func removeFollowRequestNotification(_ follow: Follow) throws {
        guard let notification = try repository.fetch(byRelatedID: follow.id, forUser: follow.target.id) else {
            return
        }
        repository.delete(notification)
        try repository.save()
    }
}
