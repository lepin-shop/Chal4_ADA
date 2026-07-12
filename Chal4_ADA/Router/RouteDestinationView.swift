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
    case itemDetail(item: Item)
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
                onSell: { AppRouter.shared.push(.post) },
                hasGoods: true
            )
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .navigationBar)
        case .sellerGoodDetail(good: let good):
            SellerGoodDetailScreen(good: good)
        case .itemDetail(item: let item):
            ItemDetailScreen(item: item)
        }
    }
}
