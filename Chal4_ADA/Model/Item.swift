//
//  Item.swift
//  Chal4_ADA
//
//  Created by Danniel on 02/07/26.
//

import Foundation

/// Status penjualan sebuah Item.
enum ItemStatus {
    case onSale
    case soldOut
    case expired
}

enum QualityGrade {
    case fresh
    case molded
}

final class Item {
    let id: UUID
    var seller: User
    var title: String
    var description: String
    var mediaUrl: String
    var qualityGrade: QualityGrade
    var quantity: Int
    var quantityAvailable: Int
    var pricePerUnit: Decimal
    var expiresAt: Date
    var status: ItemStatus
    var createdAt: Date
    var tagsVisibility: [Tag] = []

    var orders: [Order] = []   // order yang menargetkan item ini

    init(
        id: UUID = UUID(),
        seller: User,
        title: String,
        description: String,
        mediaUrl: String,
        qualityGrade: QualityGrade,
        quantity: Int,
        quantityAvailable: Int,
        pricePerUnit: Decimal,
        expiresAt: Date,
        status: ItemStatus,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.seller = seller
        self.title = title
        self.description = description
        self.mediaUrl = mediaUrl
        self.qualityGrade = qualityGrade
        self.quantity = quantity
        self.quantityAvailable = quantityAvailable
        self.pricePerUnit = pricePerUnit
        self.expiresAt = expiresAt
        self.status = status
        self.createdAt = createdAt

        // Auto-wire sisi-balik agar graf selalu konsisten.
        seller.items.append(self)
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
