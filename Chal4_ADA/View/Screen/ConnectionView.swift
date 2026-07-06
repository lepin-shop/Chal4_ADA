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

extension Item: Hashable {
    static func == (lhs: Item, rhs: Item) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

struct ConnectionView: View {
    @State private var selectedSegment: PageSegment = .all
    @State private var selectedItem: Item? = nil
    
    private let items = ItemsData.activeItems
    private let orders = ItemsData.activeOrders
    
    var body: some View {
        NavigationStack {
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
                    ItemDetailView(item: item)
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
        ForEach(items, id: \.id) { item in
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
    
    private var myOrderSegmentView: some View {
        ForEach(orders, id: \.id) { order in
                NavigationLink(destination: ItemDetailView(
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
    
    private var doneSegmentView: some View {
        VStack(spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 40))
                .foregroundStyle(.green)
            Text("No completed orders yet.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 40)
    }
    
}

#Preview {
    ConnectionView()
}
