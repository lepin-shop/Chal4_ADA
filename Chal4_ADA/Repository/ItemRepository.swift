//
//  ItemRepository.swift
//  Chal4_ADA
//
//  Created by Danniel on 11/07/26.
//

import Foundation
import SwiftData

final class ItemRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchAll() throws -> [Item] {
        let descriptor = FetchDescriptor<Item>(sortBy: [SortDescriptor(\.createdAt, order: .reverse)])
        return try context.fetch(descriptor)
    }

    func fetch(byId id: UUID) throws -> Item? {
        var descriptor = FetchDescriptor<Item>(predicate: #Predicate { $0.id == id })
        descriptor.fetchLimit = 1
        return try context.fetch(descriptor).first
    }

    func fetchOnSale() throws -> [Item] {
        let status = ItemStatus.onSale
        let descriptor = FetchDescriptor<Item>(
            predicate: #Predicate { $0.status == status },
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        return try context.fetch(descriptor)
    }

    func fetch(bySeller sellerId: UUID) throws -> [Item] {
        let descriptor = FetchDescriptor<Item>(
            predicate: #Predicate { $0.seller.id == sellerId },
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        return try context.fetch(descriptor)
    }

    func insert(_ item: Item) {
        context.insert(item)
    }

    func delete(_ item: Item) {
        context.delete(item)
    }

    func save() throws {
        try context.save()
    }
}
