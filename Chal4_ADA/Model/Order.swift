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
    var location: String
    var createdAt: Date

    init(
        id: UUID = UUID(),
        item: Item,
        buyer: User,
        quantityOrdered: Int,
        status: OrderStatus,
        totalPrice: Double,
        location: String,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.item = item
        self.buyer = buyer
        self.quantityOrdered = quantityOrdered
        self.status = status
        self.totalPrice = totalPrice
        self.location = location
        self.createdAt = createdAt

        // Auto-wire kedua sisi-balik.
        // item.orders.append(self)
        // buyer.orders.append(self)
    }
}

