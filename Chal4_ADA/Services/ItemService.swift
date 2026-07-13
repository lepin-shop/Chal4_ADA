//
//  ItemService.swift
//  Chal4_ADA
//
//  Created by Danniel on 11/07/26.
//
import Foundation
import SwiftData

final class ItemService {
    private let repository: ItemRepository
    
    init(repository: ItemRepository) {
        self.repository = repository
    }
    
    @discardableResult
    func createItem(
        seller: User,
        title: String,
        description: String,
        qualityGrade: QualityGrade,
        quantity: Int,
        pricePerUnit: Double,
        expiresAt: Date,
        imageData1: Data?,
        imageData2: Data?,
        imageData3: Data?,
        imageData4: Data?
    ) throws -> Item {
        guard quantity > 0 else { throw ItemError.invalidQuantity }
        guard pricePerUnit > 0 else { throw ItemError.invalidPrice }
        
        let item = Item(
            seller: seller,
            title: title,
            description: description,
            qualityGrade: qualityGrade,
            quantity: quantity,
            quantityAvailable: quantity,
            pricePerUnit: pricePerUnit,
            expiresAt: expiresAt,
            status: .onSale,
        )
        
        item.imageData1 = imageData1
        item.imageData2 = imageData2
        item.imageData3 = imageData3
        item.imageData4 = imageData4
        
        repository.insert(item)
        try repository.save()
        return item
    }
    
    func deleteItem(_ item: Item) throws {
        guard item.orders.isEmpty else {
            throw ItemError.cannotDeleteWithExistingOrders
        }
        repository.delete(item)
        try repository.save()
    }
    
    func updateItem(
        _ item: Item,
        title: String? = nil,
        description: String? = nil,
        quantity: Int? = nil,
        quantityAvailable: Int? = nil,
        pricePerUnit: Double? = nil,
        expiresAt: Date? = nil
    ) throws {
        if let title {
            item.title = title
        }
        if let description {
            item.itemDescription = description
        }
        if let quantity {
            guard quantity > 0 else { throw ItemError.invalidQuantity }
            item.quantity = quantity
        }
        if let quantityAvailable {
            guard quantityAvailable >= 0 else { throw ItemError.invalidQuantity }
            item.quantityAvailable = quantityAvailable
        }
        if let pricePerUnit {
            guard pricePerUnit > 0 else { throw ItemError.invalidPrice }
            item.pricePerUnit = pricePerUnit
        }
        if let expiresAt {
            item.expiresAt = expiresAt
        }
        try repository.save()
    }
    
    func changeStatus(_ item: Item, to status: ItemStatus) throws {
        item.status = status
        try repository.save()
    }
}
