//
//  AppRouter.swift
//  Chal4_ADA
//
//  Created by Danniel on 09/07/26.
//

import SwiftUI
import Combine

class AppRouter: ObservableObject {
    static var shared = AppRouter()
    
    private init() {}
    
    @Published var path: NavigationPath = NavigationPath()
    
    func push(_ route: Route) {
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func pop(_ count: Int) {
        path.removeLast(min(count, path.count))
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }

    func replace(with route: Route) {
        path.removeLast(path.count)
        path.append(route)
    }
}
