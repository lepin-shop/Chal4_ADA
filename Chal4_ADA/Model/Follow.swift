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

extension Follow {
    @discardableResult
    static func request(from requester: User, to target: User, context: ModelContext) -> Follow? {
        guard requester.id != target.id else {
            return nil
        }
        
        let alreadyExists = requester.sentFollows.contains {
            $0.target.id == target.id && $0.status != .declined
        }
        
        guard !alreadyExists else {
            return nil
        }
        
        let follow = Follow(requester: requester, target: target)
        context.insert(follow)
        return follow
    }
    
    func accept() {
        status = .accepted
        respondedAt = Date()
    }
    
    func decline() {
        status = .declined
        respondedAt = Date()
    }
}

extension User {
    func unfollow(_ target: User, context: ModelContext) {
        if let follow = sentFollows.first(
            where:
                {
                    $0.target.id == target.id && $0.status == .accepted
                }
        ) {
            context.delete(follow)
        }
    }
}

