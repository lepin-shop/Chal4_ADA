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
    
    @Attribute(.externalStorage) var imageData1: Data?
    @Attribute(.externalStorage) var imageData2: Data?
    @Attribute(.externalStorage) var imageData3: Data?
    @Attribute(.externalStorage) var imageData4: Data?
    
    var uiImage1: UIImage? {
        get {
            guard let imageData1 else {
                return nil
            }
            
            return UIImage(data: imageData1)
        }
        
        set {
            imageData1 = newValue?.jpegData(compressionQuality: 0.8)
        }
    }
    var uiImage2: UIImage? {
        get {
            guard let imageData2 else {
                return nil
            }
            
            return UIImage(data: imageData2)
        }
        
        set {
            imageData2 = newValue?.jpegData(compressionQuality: 0.8)
        }
    }
    var uiImage3: UIImage? {
        get {
            guard let imageData3 else {
                return nil
            }
            
            return UIImage(data: imageData3)
        }
        
        set {
            imageData3 = newValue?.jpegData(compressionQuality: 0.8)
        }
    }
    var uiImage4: UIImage? {
        get {
            guard let imageData4 else {
                return nil
            }
            
            return UIImage(data: imageData4)
        }
        
        set {
            imageData4 = newValue?.jpegData(compressionQuality: 0.8)
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
