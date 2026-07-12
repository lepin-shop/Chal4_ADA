//
//  NotificationScreen.swift
//  Chal4_ADA
//
//  Created by Danniel on 12/07/26.
//

import SwiftUI
import SwiftData

struct NotificationScreen: View {
    @StateObject private var router: AppRouter = AppRouter.shared
    @Query private var notifications: [Notification]
    @State private var viewModel = NotificationScreenViewModel()
    
    init() {
        let userId = SessionManager.shared.currentUser?.id
        let predicate = #Predicate<Notification> { $0.user?.id == userId }
        _notifications = Query(filter: predicate, sort: [SortDescriptor(\.timestamp, order: .reverse)])
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            Group {
                if notifications.isEmpty {
                    VStack (spacing: 0) {
                        Spacer()
                        NoNotificationView().padding(.bottom, 64)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.background)
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(groupedNotifications, id: \.label) { group in
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(group.label)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                        .padding(.horizontal, 4)
                                    
                                    VStack(spacing: 0) {
                                        ForEach(Array(group.items.enumerated()), id: \.element.id) { index, notification in
                                            NotificationRow(notification: notification) {
                                                handleTap(notification)
                                            }
                                            if index < group.items.count - 1 {
                                                Divider().padding(.leading, 78)
                                            }
                                        }
                                    }
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                                
                            }
                        }
                        .padding()
                    }
                    .background(Color(.background))
                }
            }
            .navigationTitle("Notifikasi")
            .navigationDestination(for: Route.self) { route in
                RouteDestinationView(route: route)
            }
        }
    }
    
    private var groupedNotifications: [(label: String, items: [Notification])] {
        let calendar = Calendar.current
        let groups = Dictionary(grouping: notifications) { calendar.startOfDay(for: $0.timestamp) }
        return groups.keys.sorted(by: >).map { day in
            (label: dayLabel(for: day), items: (groups[day] ?? []).sorted { $0.timestamp > $1.timestamp })
        }
    }
    
    private func dayLabel(for day: Date) -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(day) {
            return "Hari Ini"
        } else if calendar.isDateInYesterday(day) {
            return "Kemarin"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMMM yyyy"
            formatter.locale = Locale(identifier: "id_ID")
            return formatter.string(from: day)
        }
    }
    
    private func handleTap(_ notification: Notification) {
        switch notification.type {
        case .incomingOrder:
            // TODO: navigate to order detail, e.g.:
            // if let relatedID = notification.relatedID {
            //     router.path.append(Route.orderDetail(relatedID))
            // }
            break
        case .followRequest(let isAccepted):
            guard !isAccepted else { return }
            viewModel.acceptFollowRequest(from: notification)
        }
    }
}

#Preview {
    NotificationScreen()
        .environment(SessionManager.shared)
        .modelContainer(AppContainer.shared.modelContainer)
}
