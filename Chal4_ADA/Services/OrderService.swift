//
//  OrderError.swift
//  Chal4_ADA
//
//  Created by Danniel on 11/07/26.
//

import Foundation
import SwiftData

final class OrderService {
    private let repository: OrderRepository
    
    init(repository: OrderRepository) {
        self.repository = repository
    }
    
    @discardableResult
    func placeOrder(buyer: User, item: Item, quantity: Int, notes: String? = nil) throws -> Order {
        guard item.status == .onSale else {
            throw OrderError.itemNotOnSale
        }
        guard quantity > 0 else {
            throw OrderError.invalidQuantity
        }
        guard item.quantityAvailable >= quantity else {
            throw OrderError.insufficientQuantity
        }
        
        let order = Order(
            item: item,
            buyer: buyer,
            quantityOrdered: quantity,
            status: .inProgress,
            totalPrice: item.pricePerUnit * Double(quantity),
            notes: notes
        )
        
        item.quantityAvailable -= quantity
        if item.quantityAvailable == 0 {
            item.status = .soldOut
        }
        
        repository.insert(order)
        try repository.save()
        return order
    }
    
    func completeOrder(_ order: Order, enteredCode: String) throws {
        guard order.status == .inProgress else {
            throw OrderError.orderNotInProgress
        }
        guard order.completionCode == enteredCode else {
            throw OrderError.invalidCode
        }
        order.status = .done
        try repository.save()
    }
    
    func cancelOrder(_ order: Order) throws {
        guard order.status == .inProgress else {
            throw OrderError.orderNotInProgress
        }
        order.status = .cancelled
        
        let item = order.item
        item.quantityAvailable += order.quantityOrdered
        if item.status == .soldOut {
            item.status = .onSale
        }
        
        try repository.save()
    }
}
