//
//  Order.swift
//  Chal4_ADA
//
//  Created by Danniel on 02/07/26.
//
import Foundation
import SwiftData

@Model
final class Order {
    @Attribute(.unique) var id: UUID
    var item: Item
    var buyer: User
    var quantityOrdered: Int
    var status: OrderStatus
    var totalPrice: Double
    var notes: String?
    var completionCode: String
    var createdAt: Date

    init(
        id: UUID = UUID(),
        item: Item,
        buyer: User,
        quantityOrdered: Int,
        status: OrderStatus,
        totalPrice: Double,
        notes: String? = nil,
        completionCode: String = Order.generateCompletionCode(),
        createdAt: Date = Date()
    ) {
        self.id = id
        self.item = item
        self.buyer = buyer
        self.quantityOrdered = quantityOrdered
        self.status = status
        self.totalPrice = totalPrice
        self.notes = notes
        self.completionCode = completionCode
        self.createdAt = createdAt
    }
}

extension Order {
    static func generateCompletionCode() -> String {
        String(format: "%06d", Int.random(in: 0...999_999))
    }
}
