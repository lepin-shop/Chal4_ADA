//
//  RouteDestinationView.swift
//  Chal4_ADA
//
//  Created by Danniel on 09/07/26.
//

import SwiftUI


enum Route: Hashable {
    case post
    case orders
    case itemDetail(item: Item)
}

struct RouteDestinationView: View {
    let route: Route
    
    var body: some View {
        switch route {
        case .post:
            PostItemScreen()
        case .itemDetail(item: let item):
            ItemDetailScreen(item: item)
        case .orders:
            CartScreen()
        }
        
    }
}
