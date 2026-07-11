//
//  FollowService.swift
//  Chal4_ADA
//
//  Created by Danniel on 11/07/26.
//
import Foundation
import SwiftData

final class FollowService {
    private let repository: FollowRepository
    
    init(repository: FollowRepository) {
        self.repository = repository
    }
    
    @discardableResult
    func sendRequest(from requester: User, to target: User) throws -> Follow {
        guard requester.id != target.id else {
            throw FollowError.cannotFollowSelf
        }
        
        let alreadyExists = requester.sentFollows.contains {
            $0.target.id == target.id && $0.status != .declined
        }
        guard !alreadyExists else {
            throw FollowError.requestAlreadyExists
        }
        
        let follow = Follow(requester: requester, target: target)
        repository.insert(follow)
        try repository.save()
        
        return follow
    }
    
    func accept(_ follow: Follow) throws {
        guard follow.status == .pending else {
            throw FollowError.notPending
        }
        
        follow.status = .accepted
        follow.respondedAt = Date()
        try repository.save()
    }
    
    func decline(_ follow: Follow) throws {
        guard follow.status == .pending else {
            throw FollowError.notPending
        }
        follow.status = .declined
        follow.respondedAt = Date()
        try repository.save()
    }
    
    func unfollow(user: User, target: User) throws {
        guard let follow = user.sentFollows.first(where: {
            $0.target.id == target.id && $0.status == .accepted
        }) else {
            throw FollowError.followNotFound
        }
        repository.delete(follow)
        try repository.save()
    }
}
