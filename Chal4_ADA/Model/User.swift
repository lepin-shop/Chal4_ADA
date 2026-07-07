//
//  User.swift
//  Chal4_ADA
//
//  Created by Danniel on 02/07/26.
//
import Foundation
import SwiftData

@Model
final class User {
    @Attribute(.unique) var id: UUID
    var name: String
    var phone: String
    var location: String
    var createdAt: Date

    /// Relasi to-many. Default kosong: inilah yang memutus circular-init,
    /// sehingga tidak perlu optional di mana pun.
    /// item yang dijual user ini (sebagai seller)
    @Relationship(deleteRule: .cascade, inverse: \Item.seller)
    var items: [Item] = []

    /// order yang dibuat user ini (sebagai buyer)
    @Relationship(deleteRule: .cascade, inverse: \Order.buyer)
    var orders: [Order] = []

    /// tag yang dimiliki user ini
    @Relationship(deleteRule: .cascade, inverse: \Tag.owner)
    var ownedTags: [Tag] = []

    // Relasi user-ke-user (model follow terarah, mirip Instagram).
    var following: [User] = []   // seller/user yang di-connect oleh user ini
    var followers: [User] = []   // user yang meng-connect ke user ini
    
    init(
        id: UUID = UUID(),
        name: String,
        phone: String,
        location: String,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.phone = phone
        self.location = location
        self.createdAt = createdAt
    }
}
