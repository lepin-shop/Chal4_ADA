//
//  ItemError.swift
//  Chal4_ADA
//
//  Created by Danniel on 11/07/26.
//
import Foundation

enum ItemError: LocalizedError {
    case cannotDeleteWithExistingOrders
    case invalidQuantity
    case invalidPrice
 
    var errorDescription: String? {
        switch self {
        case .cannotDeleteWithExistingOrders:
            return "Item ini tidak dapat dihapus karena terdapat pesanan aktif!."
        case .invalidQuantity:
            return "Quantity must be greater than zero."
        case .invalidPrice:
            return "Price must be greater than zero."
        }
    }
}
