//
//  UserRepository.swift
//  Chal4_ADA
//
//  Created by Danniel on 11/07/26.
//

import Foundation
import SwiftData

final class UserRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchAll() throws -> [User] {
        let descriptor = FetchDescriptor<User>(sortBy: [SortDescriptor(\.name)])
        return try context.fetch(descriptor)
    }

    func fetch(byId id: UUID) throws -> User? {
        var descriptor = FetchDescriptor<User>(predicate: #Predicate { $0.id == id })
        descriptor.fetchLimit = 1
        return try context.fetch(descriptor).first
    }

    func insert(_ user: User) {
        context.insert(user)
    }

    func delete(_ user: User) {
        context.delete(user)
    }

    func save() throws {
        try context.save()
    }
}
