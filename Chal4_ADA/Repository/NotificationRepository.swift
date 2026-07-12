//
//  NotificationRepository.swift
//  Chal4_ADA
//
//  Created by Danniel on 12/07/26.
//


//
//  NotificationRepository.swift
//  Chal4_ADA
//

import Foundation
import SwiftData

final class NotificationRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchAll() throws -> [Notification] {
        let descriptor = FetchDescriptor<Notification>(sortBy: [SortDescriptor(\.timestamp, order: .reverse)])
        return try context.fetch(descriptor)
    }

    func fetch(byId id: UUID) throws -> Notification? {
        var descriptor = FetchDescriptor<Notification>(predicate: #Predicate { $0.id == id })
        descriptor.fetchLimit = 1
        return try context.fetch(descriptor).first
    }

    func fetch(forUser userId: UUID) throws -> [Notification] {
        let descriptor = FetchDescriptor<Notification>(
            predicate: #Predicate { $0.user?.id == userId },
            sortBy: [SortDescriptor(\.timestamp, order: .reverse)]
        )
        return try context.fetch(descriptor)
    }

    func fetch(byRelatedID relatedID: UUID, forUser userId: UUID) throws -> Notification? {
        var descriptor = FetchDescriptor<Notification>(
            predicate: #Predicate { $0.relatedID == relatedID && $0.user?.id == userId }
        )
        descriptor.fetchLimit = 1
        return try context.fetch(descriptor).first
    }

    func insert(_ notification: Notification) {
        context.insert(notification)
    }

    func delete(_ notification: Notification) {
        context.delete(notification)
    }

    func save() throws {
        try context.save()
    }
}
