//
//  OrderPageSection.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 11/07/26.
//

import SwiftUI

struct OrderPageSection: View {
    @Environment(SessionManager.self) private var session
    
    @State var currentOrderFilter: OrderPageSegment = .myOrder
    
    // kayaknya taro viewModel
    private let orders = ItemsData.activeOrders
    private let completeOrders = ItemsData.completedOrders
    
    private var myOrders: [Order] {
        guard let currentUserID = session.activeUserID else { return [] }
        return orders.filter { $0.buyer.id.uuidString == currentUserID }
    }
    
    private var completedOrders: [Order] {
        guard let currentUserID = session.activeUserID else { return [] }
        return completeOrders.filter { $0.buyer.id.uuidString == currentUserID }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            OrderSegmentControl(currentOrderFilter: $currentOrderFilter)
            
            Group {
                switch currentOrderFilter {
                case .myOrder:
                    if myOrders.isEmpty {
                        EmptyState(icon: "doc.text.magnifyingglass", message: "Kamu belum memiliki pesanan aktif.")
                    } else {
                        ForEach(myOrders, id: \.id) { order in
                            // TODO: Replace this so it should using app router
                            NavigationLink(destination: ActiveOrderDetailScreen(item: order.item, quantityBought: order.item.quantity)) {
                                CartListCard(
                                    imageName: order.item.mediaUrl,
                                    grade: String(describing: order.item.qualityGrade),
                                    title: order.item.title,
                                    stock: order.item.quantity,
                                    price: NSDecimalNumber(decimal: Decimal(order.item.pricePerUnit)).doubleValue,
                                    expiryDate: order.item.expiresAt
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    
                case .done:
                    if completedOrders.isEmpty {
                        EmptyState(icon: "checkmark.circle.fill", message: "Belum ada pesanan yang selesai.")
                    } else {
                        ForEach(completedOrders, id: \.id) { order in
                            CartListCard(
                                imageName: order.item.mediaUrl,
                                grade: String(describing: order.item.qualityGrade),
                                title: order.item.title,
                                stock: order.item.quantity,
                                price: NSDecimalNumber(decimal: Decimal(order.item.pricePerUnit)).doubleValue,
                                expiryDate: order.item.expiresAt
                            )
                        }
                    }
                }
            }
        }
    }
}
