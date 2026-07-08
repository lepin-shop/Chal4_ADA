//
//  SessionManager.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 08/07/26.
//

import Foundation
import SwiftUI

/// Simulates "who is currently using the app" for the prototype.
///
/// This is intentionally NOT SwiftData — it's transient session state,
/// not business data. Persisted via UserDefaults so the active user
/// survives an app relaunch (same underlying mechanism as @AppStorage,
/// written as a plain class so it's safe to use outside View bodies).
@Observable
final class SessionManager {
    private let storageKey = "activeUserID"

    /// The UUID string of whichever User is currently "logged in".
    /// nil means no one is active (logged out).
    var activeUserID: String? {
        didSet {
            UserDefaults.standard.set(activeUserID, forKey: storageKey)
        }
    }

    init() {
        activeUserID = UserDefaults.standard.string(forKey: storageKey)
    }

    /// Switches the active session to the given user.
    func setActiveUser(_ user: User) {
        activeUserID = user.id.uuidString
    }

    /// Clears the active session.
    func logout() {
        activeUserID = nil
    }

    /// Resolves the currently active User against a known list of users
    /// (e.g. SampleData's dummy users, or a @Query result once real
    /// persistence is wired in). Returns nil if nothing matches.
    func resolveCurrentUser(in users: [User]) -> User? {
        guard let activeUserID else { return nil }
        return users.first { $0.id.uuidString == activeUserID }
    }
}
