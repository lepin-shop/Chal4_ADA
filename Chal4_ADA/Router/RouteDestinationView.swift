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
                .toolbar(.hidden, for: .tabBar)
                .environment(TemporaryImagePosts.shared)
        case .postSuccess:
            PostSuccessScreen()
                .toolbar(.hidden, for: .navigationBar)
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
                .toolbar(.hidden, for: .tabBar)
        case .home:
            MainTabView()
        case .switchAccount:
            AccountSwitcherScreen()
                .toolbar(.hidden, for: .tabBar)
        case .itemDetail(item: let item):
            ItemDetailScreen(item: item)
                .toolbar(.hidden, for: .tabBar)
        case .orders:
            CartScreen()
                .toolbar(.hidden, for: .tabBar)
        case .activeOrderDetailScreen(order: let order):
            ActiveOrderDetailScreen(order: order, item: order.item, quantityBought: order.quantityOrdered)
                .toolbar(.hidden, for: .tabBar)
        }
    }
}
