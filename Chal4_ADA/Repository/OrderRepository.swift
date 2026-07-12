//
//  OrderRepository.swift
//  Chal4_ADA
//
//  Created by Danniel on 11/07/26.
//

import Foundation
import SwiftData

final class OrderRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchAll() throws -> [Order] {
        let descriptor = FetchDescriptor<Order>(sortBy: [SortDescriptor(\.createdAt, order: .reverse)])
        return try context.fetch(descriptor)
    }

    func fetch(byId id: UUID) throws -> Order? {
        var descriptor = FetchDescriptor<Order>(predicate: #Predicate { $0.id == id })
        descriptor.fetchLimit = 1
        return try context.fetch(descriptor).first
    }
    
    func fetch(byBuyer buyerId: UUID) throws -> [Order] {
        let descriptor = FetchDescriptor<Order>(
            predicate: #Predicate { $0.buyer.id == buyerId },
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        return try context.fetch(descriptor)
    }

    func fetch(byItem itemId: UUID) throws -> [Order] {
        let descriptor = FetchDescriptor<Order>(
            predicate: #Predicate { $0.item.id == itemId },
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        return try context.fetch(descriptor)
    }

    func fetch(bySeller sellerId: UUID) throws -> [Order] {
        let descriptor = FetchDescriptor<Order>(
            predicate: #Predicate { $0.item.seller.id == sellerId },
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        return try context.fetch(descriptor)
    }

    func insert(_ order: Order) {
        context.insert(order)
    }

    func delete(_ order: Order) {
        context.delete(order)
    }

    func save() throws {
        try context.save()
    }
}
