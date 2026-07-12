//
//  OrderPageSection.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 11/07/26.
//

import SwiftUI
import SwiftData

struct OrderPageSection: View {
    @State var currentOrderFilter: OrderPageSegment = .myOrder
    @Query var orders: [Order]
    
    init() {
        let buyerId = SessionManager.shared.currentUser?.id ?? UUID()
        let predicate = #Predicate<Order> { $0.buyer.id == buyerId }
        _orders = Query(filter: predicate, sort: [SortDescriptor(\.createdAt, order: .reverse)])
    }
    
    var inProgressOrders: [Order] {
        return orders.filter {
            $0.status == .inProgress
        }
    }
    
    var completedOrders: [Order] {
        return orders.filter {
            $0.status == .done
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            OrderSegmentControl(currentOrderFilter: $currentOrderFilter)
            
            switch currentOrderFilter {
            case .myOrder:
                if orders.isEmpty {
                    EmptyState(icon: "doc.text.magnifyingglass", message: "Kamu belum memiliki pesanan aktif.")
                } else {
                    ForEach(inProgressOrders, id: \.id) { order in
                        // TODO: Replace this so it should using app router
                        NavigationLink(value: Route.activeOrderDetailScreen(order: order)) {
                            CartListCard(
                                image: order.item.uiImage,
                                grade: String(describing: order.item.qualityGrade),
                                title: order.item.title,
                                stock: order.quantityOrdered,
                                price: NSDecimalNumber(decimal: Decimal(order.totalPrice)).doubleValue,
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
                            image: order.item.uiImage,
                            grade: String(describing: order.item.qualityGrade),
                            title: order.item.title,
                            stock: order.quantityOrdered,
                            price: NSDecimalNumber(decimal: Decimal(order.totalPrice)).doubleValue,
                            expiryDate: order.item.expiresAt
                        )
                    }
                }
            }
        }
    }
}
