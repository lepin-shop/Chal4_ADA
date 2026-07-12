//
//  RouteDestinationView.swift
//  Chal4_ADA
//
//  Created by Danniel on 09/07/26.
//

import SwiftUI


enum Route: Hashable {
    case post
    case postSuccess
    case sellerGoods
    case sellerGoodDetail(good: SellerGood)
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
        case .post:
            PostItemScreen()
        case .postSuccess:
            PostSuccessScreen()
        case .sellerGoods:
            EmptyGoodsScreen(
                onSell: {
                    AppRouter.shared.push(.post)
                },
            )
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .navigationBar)
        case .sellerGoodDetail(good: let good):
            SellerGoodDetailScreen(good: good)
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
