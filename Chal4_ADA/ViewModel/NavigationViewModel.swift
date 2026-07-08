//
//  NavigationViewModel.swift
//  Chal4_ADA
//
//  Created by Danniel on 06/07/26.
//

import SwiftUI
import Combine

class NavigationViewModel: ObservableObject {
    @Published var path = NavigationPath()
    
    func goToPost() {
        path.append(Route.post) 
    }
}
