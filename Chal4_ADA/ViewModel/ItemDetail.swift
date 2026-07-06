//
//  ItemDetail.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 02/07/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class ItemDetail: ObservableObject {
    let item: Item
    
    @Published var selectedQuantity: Int = 1
    @Published var showConfirmationSheet: Bool = false
    @Published var showQRScreen: Bool = false
    @Published var selectedPickupTime: String = "09:00"
    
    let pickupTimeSlots: [String] = ["09:00", "10:00", "11:00", "13:00", "14:00"]
    
    init(item: Item) {
        self.item = item
    }
    
    var totalPrice: Double {
        Double(selectedQuantity) * item.pricePerUnit
    }
    
    var formattedTotal: String {
        "Rp\(Int(totalPrice).formatted())"
    }
    
    var canDecrement: Bool {
        selectedQuantity > 1
    }
    
    var canIncrement: Bool {
        selectedQuantity < item.quantityAvailable
    }
    
    func increment() {
        guard canIncrement else { return }
        selectedQuantity += 1
    }
    
    func decrement() {
        guard canDecrement else { return }
        selectedQuantity -= 1
    }
    
    func bookPickup() {
        showConfirmationSheet = true
    }
    
    func confirmBooking() {
        showConfirmationSheet = false
        // slight delay so sheet dismiss animates cleanly before QR pushes
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            self.showQRScreen = true
        }
    }
}
