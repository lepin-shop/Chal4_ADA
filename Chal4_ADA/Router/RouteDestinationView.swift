//
//  RouteDestinationView.swift
//  Chal4_ADA
//
//  Created by Danniel on 09/07/26.
//

import SwiftUI


enum Route: Hashable {
    case switchAccount
    case home
    case itemDetail(item: Item)
    case orders
    case activeOrderDetailScreen(order: Order)
}

struct RouteDestinationView: View {
    let route: Route
    
    var body: some View {
        switch route {
        case .home:
            MainTabView()
        case .switchAccount:
            AccountSwitcherScreen()
        case .itemDetail(item: let item):
            ItemDetailScreen(item: item)
        case .orders:
            CartScreen()
        case .activeOrderDetailScreen(order: let order):
            ActiveOrderDetailScreen(order: order, item: order.item, quantityBought: order.quantityOrdered)
        }
    }
}
