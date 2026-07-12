//
//  FollowRepository.swift
//  Chal4_ADA
//
//  Created by Danniel on 11/07/26.
//

import Foundation
import SwiftData

final class FollowRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchAll() throws -> [Follow] {
        try context.fetch(FetchDescriptor<Follow>())
    }

    func fetch(byId id: UUID) throws -> Follow? {
        var descriptor = FetchDescriptor<Follow>(predicate: #Predicate { $0.id == id })
        descriptor.fetchLimit = 1
        return try context.fetch(descriptor).first
    }

    /// The follow record (if any) from a specific requester to a specific target.
    func fetch(requesterId: UUID, targetId: UUID) throws -> Follow? {
        var descriptor = FetchDescriptor<Follow>(
            predicate: #Predicate { $0.requester.id == requesterId && $0.target.id == targetId }
        )
        descriptor.fetchLimit = 1
        return try context.fetch(descriptor).first
    }

    func insert(_ follow: Follow) {
        context.insert(follow)
    }

    func delete(_ follow: Follow) {
        context.delete(follow)
    }

    func save() throws {
        try context.save()
    }
}
