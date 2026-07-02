//
//  Tag.swift
//  Chal4_ADA
//
//  Created by Danniel on 02/07/26.
//
import Foundation

final class Tag: Equatable {
    let id: UUID
    var owner: User
    var label: String
    var createdAt: Date
 
    init(
        id: UUID = UUID(),
        owner: User,
        label: String,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.owner = owner
        self.label = label
        self.createdAt = createdAt
 
        owner.ownedTags.append(self)
    }
    
    static func == (lhs: Tag, rhs: Tag) -> Bool {
        lhs.id == rhs.id
    }
}
