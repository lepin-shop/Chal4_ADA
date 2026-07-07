//
//  Item.swift
//  Chal4_ADA
//
//  Created by Danniel on 02/07/26.
//

import Foundation
import SwiftData

/// Status penjualan sebuah Item.
enum ItemStatus: String, Codable {
    case onSale
    case soldOut
    case expired
}

enum QualityGrade: String, Codable {
    case A
    case B
    case C
}

@Model
final class Item {
    @Attribute(.unique) var id: UUID
    var seller: User
    var title: String
    var itemDescription: String
    var mediaUrl: String
    var qualityGrade: QualityGrade
    var quantity: Int
    var quantityAvailable: Int
    var pricePerUnit: Double
    var expiresAt: Date
    var status: ItemStatus
    var createdAt: Date
    
    
    @Relationship(deleteRule: .cascade, inverse: \Order.item)
    var orders: [Order] = []   // order yang menargetkan item ini
    
    // one-to-many one item could be scoped to several tags
    @Relationship(inverse: \Tag.visibleItems)
    var tagsVisibility: [Tag] = []

    init(
        id: UUID = UUID(),
        seller: User,
        title: String,
        description: String,
        mediaUrl: String,
        qualityGrade: QualityGrade,
        quantity: Int,
        quantityAvailable: Int,
        pricePerUnit: Double,
        expiresAt: Date,
        status: ItemStatus,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.seller = seller
        self.title = title
        self.itemDescription = description
        self.mediaUrl = mediaUrl
        self.qualityGrade = qualityGrade
        self.quantity = quantity
        self.quantityAvailable = quantityAvailable
        self.pricePerUnit = pricePerUnit
        self.expiresAt = expiresAt
        self.status = status
        self.createdAt = createdAt

        // Auto-wire sisi-balik agar graf selalu konsisten.
        // seller.items.append(self)
    }
    
    func add_tag (_ tag: Tag) {
        if !tagsVisibility.contains(tag) {
            tagsVisibility.append(tag)
        }
    }
}

enum PostFilter: String, CaseIterable, Identifiable {
    case active = "Active", booked = "Booked", done = "Done"
    var id: Self { self }
}
