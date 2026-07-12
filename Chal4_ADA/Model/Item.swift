//
//  Item.swift
//  Chal4_ADA
//
//  Created by Danniel on 02/07/26.
//

import Foundation
import SwiftData
import UIKit

@Model
final class Item {
    @Attribute(.unique) var id: UUID
    var seller: User
    var title: String
    var itemDescription: String
    var qualityGrade: QualityGrade
    var quantity: Int
    var quantityAvailable: Int
    var pricePerUnit: Double
    var expiresAt: Date
    var status: ItemStatus
    var createdAt: Date
    
    @Attribute(.externalStorage) var imageData: Data?
    
    var uiImage: UIImage? {
        get {
            guard let imageData else {
                return nil
            }
            
            return UIImage(data: imageData)
        }
        
        set {
            imageData = newValue?.jpegData(compressionQuality: 0.8)
        }
    }
    
    @Relationship(deleteRule: .cascade, inverse: \Order.item)
    var orders: [Order] = [] 

    init(
        id: UUID = UUID(),
        seller: User,
        title: String,
        description: String,
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
        self.qualityGrade = qualityGrade
        self.quantity = quantity
        self.quantityAvailable = quantityAvailable
        self.pricePerUnit = pricePerUnit
        self.expiresAt = expiresAt
        self.status = status
        self.createdAt = createdAt
    }
}
