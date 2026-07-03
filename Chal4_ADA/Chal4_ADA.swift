import SwiftUI

// Entry point aplikasi
@main
struct Chal4_ADAApp: App {
    // historyStore dibuat sekali di level App supaya bisa diakses dari semua layar
    @StateObject private var historyStore = HistoryStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(historyStore)
        }
    }
}
