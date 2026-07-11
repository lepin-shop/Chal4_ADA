//
//  SessionManager.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 08/07/26.
//

import Foundation
import SwiftUI

@Observable
final class SessionManager {
    static let shared = SessionManager()

    private let storageKey = "activeUserID"
    private(set) var activeUserID: String? {
        didSet {
            UserDefaults.standard.set(activeUserID, forKey: storageKey)
        }
    }
    
    var currentUser: User?
    var role: UserRole = .buyer

    var isUserLoggedIn: Bool {
        currentUser != nil
    }

    private init() {
        activeUserID = UserDefaults.standard.string(forKey: storageKey)
    }

    func setActiveUser(_ user: User, role: UserRole) {
        currentUser = user
        activeUserID = user.id.uuidString
        self.role = role
    }

    func logout() {
        currentUser = nil
        activeUserID = nil
    }
}
