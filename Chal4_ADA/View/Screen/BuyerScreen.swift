//
//  HomeView.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 02/07/26.
//

import Foundation
import SwiftUI

enum PageSegment: String, CaseIterable {
    case all = "All"
    case myOrder = "My Order"
    case done = "Done"
}

struct BuyerScreen: View {
    @Environment(SessionManager.self) private var session
    @State private var selectedSegment: PageSegment = .all
    @State private var selectedItem: Item? = nil
    @StateObject private var router = AppRouter.shared
    
    // taro ViewModel
    private let items = ItemsData.activeItems
    private let orders = ItemsData.activeOrders
    private let completeOrders = ItemsData.completedOrders
    
    private var browsableItems: [Item] {
        guard let currentUserID = session.activeUserID else { return items }
        return items.filter { $0.seller.id.uuidString != currentUserID }
    }
    
    private var myOrders: [Order] {
        guard let currentUserID = session.activeUserID else { return [] }
        return orders.filter { $0.buyer.id.uuidString == currentUserID }
    }
    private var completedOrders: [Order] {
        guard let currentUserID = session.activeUserID else { return [] }
        return completeOrders.filter { $0.buyer.id.uuidString == currentUserID }
    }
    // taro viewModel
    
    var body: some View {
        NavigationStack (path: $router.path){
            VStack(spacing: 0) {
                HStack {
                    Text("Shop")
                        .font(.largeTitle.weight(.bold))
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .background(Color(.systemGroupedBackground))
                
                
                Picker("Connection Segments", selection: $selectedSegment) {
                    ForEach(PageSegment.allCases, id: \.self) { segment in
                        Text(segment.rawValue)
                            .tag(segment)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(.systemGroupedBackground))
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        switch selectedSegment {
                        case .all:
                            allSegmentView
                        case .myOrder:
                            myOrderSegmentView
                        case .done:
                            doneSegmentView
                        }
                        
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
                .navigationDestination(item: $selectedItem) { item in
                    RouteDestinationView(route: Route.itemDetail(item: item))
                }
                .background(Color(.systemGroupedBackground))
            }
            .navigationTitle("Connections")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItem {
                    Button("Account", systemImage: "bell", action: {}
                           
                    )
                    .badge(3)
                    .tint(.black)
                }
            }
        }
    }
    
    private var allSegmentView: some View {
        Group {
            if browsableItems.isEmpty {
                EmptyState(
                    icon: "basket",
                    message: "Belum ada barang yang tersedia."
                )
            } else {
                ForEach(browsableItems, id: \.id) { item in
                    ItemCard(
                        item: item,
                        buttonText: "Order",
                        buttonColor: .blue,
                        grade: String(describing: item.qualityGrade),
                        quantity: item.quantity,
                        price: NSDecimalNumber(decimal: Decimal(item.pricePerUnit)).doubleValue
                    ) {
                        selectedItem = item
                    }
                }
            }
        }
    }
    
    private var myOrderSegmentView: some View {
        Group {
            if myOrders.isEmpty {
                EmptyState(
                    icon: "doc.text.magnifyingglass",
                    message: "Kamu belum memiliki pesanan aktif."
                )
            } else {
                ForEach(myOrders, id: \.id) { order in
                    NavigationLink(destination: ItemDetailScreen(
                        item: order.item,
                        primaryButtonText: "Batalkan pemesanan",
                        buttonTextColor: Color.red,
                        isCheckoutMode: false,
                        buttonBackgroundColor: Color(.systemGray5),
                        onPrimaryAction: { quantity, total in
                            print("Order cancelled!")
                            // future logic button
                        }
                    )) {
                        ItemCard(
                            item: order.item,
                            buttonText: "Detail",
                            buttonColor: Color.green,
                            grade: String(describing: order.item.qualityGrade),
                            quantity: order.item.quantity,
                            price: NSDecimalNumber(decimal: Decimal(order.item.pricePerUnit)).doubleValue
                        ) {
                            selectedItem = order.item
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
    
    private var doneSegmentView: some View {
        Group {
            // Assuming you have a completedOrders array in your real data
            if completedOrders.isEmpty {
                EmptyState(
                    icon: "checkmark.circle.fill",
                    message: "Belum ada pesanan yang selesai.",
                    iconColor: .green // Custom green color for the "Done" state
                )
            } else {
                ForEach(completedOrders, id: \.id) { order in
                    NavigationLink(destination: ItemDetailScreen(
                        item: order.item,
                        primaryButtonText: "Batalkan pemesanan",
                        buttonTextColor: Color.red,
                        isCheckoutMode: false,
                        buttonBackgroundColor: Color(.systemGray5),
                        onPrimaryAction: { quantity, total in
                            print("Order cancelled!")
                            // future logic button
                        }
                    )) {
                        ItemCard(
                            item: order.item,
                            buttonText: "Detail",
                            buttonColor: Color.green,
                            grade: String(describing: order.item.qualityGrade),
                            quantity: order.item.quantity,
                            price: NSDecimalNumber(decimal: Decimal(order.item.pricePerUnit)).doubleValue
                        ) {
                            selectedItem = order.item
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
    
}

#Preview {
    BuyerScreen()
        .environment(SessionManager.shared)
}
