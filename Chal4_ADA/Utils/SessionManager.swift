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
    
    var role: UserRole = .buyer
    
    private let storageKey = "activeUserID"
    
    private var activeUserID: String? {
        didSet {
            UserDefaults.standard.set(activeUserID, forKey: storageKey)
        }
    }
    
    var isUserLoggedIn: Bool {
        activeUserID != nil
    }
    
    private init() {
        activeUserID = UserDefaults.standard.string(forKey: storageKey)
    }
    
    func setActiveUser(_ user: User, role: UserRole) {
        activeUserID = user.id.uuidString
        self.role = role
    }
    
    func logout() {
        activeUserID = nil
    }
    
    func resolveCurrentUser(in users: [User]) -> User? {
        guard let activeUserID else { return nil }
        return users.first { $0.id.uuidString == activeUserID }
    }
}
