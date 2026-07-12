//
//  OrderError.swift
//  Chal4_ADA
//
//  Created by Danniel on 11/07/26.
//
import Foundation

enum OrderError: LocalizedError {
    case itemNotOnSale
    case insufficientQuantity
    case invalidQuantity
    case invalidCode
    case orderNotInProgress
    
    var errorDescription: String? {
        switch self {
        case .itemNotOnSale:
            return "This item is not currently on sale."
        case .insufficientQuantity:
            return "Not enough quantity available for this order."
        case .invalidQuantity:
            return "Quantity must be greater than zero."
        case .invalidCode:
            return "The code entered doesn't match this order."
        case .orderNotInProgress:
            return "This order is no longer in progress."
        }
    }
}
