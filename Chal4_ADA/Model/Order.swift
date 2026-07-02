//
//  Order.swift
//  Chal4_ADA
//
//  Created by Danniel on 02/07/26.
//
import Foundation

/// Status siklus hidup sebuah Order.
enum OrderStatus {
    case inProgress
    case done
    case canceled
}

final class Order {
    let id: UUID
    var item: Item
    var buyer: User
    var quantityOrdered: Int
    var status: OrderStatus
    var totalPrice: Decimal
    var createdAt: Date

    init(
        id: UUID = UUID(),
        item: Item,
        buyer: User,
        quantityOrdered: Int,
        status: OrderStatus,
        totalPrice: Decimal,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.item = item
        self.buyer = buyer
        self.quantityOrdered = quantityOrdered
        self.status = status
        self.totalPrice = totalPrice
        self.createdAt = createdAt

        // Auto-wire kedua sisi-balik.
        item.orders.append(self)
        buyer.orders.append(self)
    }
}

