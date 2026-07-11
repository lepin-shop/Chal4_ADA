//
//  RouteDestinationView.swift
//  Chal4_ADA
//
//  Created by Danniel on 09/07/26.
//

import SwiftUI


enum Route: Hashable {
    case post
    case switchAccount
    case home
}

struct RouteDestinationView: View {
    let route: Route
    
    var body: some View {
        switch route {
        case .post:
            PostItemScreen()
        case .home:
            MainTabView()
        case .switchAccount:
            AccountSwitcherScreen()
        }
    }
}
