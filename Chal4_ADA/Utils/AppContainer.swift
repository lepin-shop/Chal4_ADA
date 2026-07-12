//
//  AppContainer.swift
//  Chal4_ADA
//
//  Created by Danniel on 11/07/26.
//

/*
 Dear developer in the future, sorry to use this pattern of singleton.
 We just need this quick and with no testing.
 If you are planning to do some testing within the application..
 use Singleton only if conceptually.. you need 1 instance only :D
 
 In fact if we use no singleton on this abomination.. we can plug in and out like this...
 func testItemRepositoryFetchOnSale() throws {
 let config = ModelConfiguration(isStoredInMemoryOnly: true)
 let container = try ModelContainer(for: User.self, Item.self, Order.self, Follow.self, configurations: config)
 let appContainer = AppContainer(context: container.mainContext)
 
 let seller = User(name: "Test Seller", phone: "0", location: "Test")
 try appContainer.itemService.createItem(seller: seller, title: "Apel", description: "", qualityGrade: .fresh, quantity: 5, pricePerUnit: 10, expiresAt: .now)
 }
 
 Best Regards,
 Danniel
 
 
 Tambahan:
 Jika anda menggunakan modelContainer di Singleton ini di Preview.
 Anda tidak perlu takut menyampah di persistance database
 */

import Foundation
import SwiftData

final class AppContainer {
    static let shared = AppContainer()
    
    let modelContainer: ModelContainer
    let userRepository: UserRepository
    let itemRepository: ItemRepository
    let orderRepository: OrderRepository
    let followRepository: FollowRepository
    let notificationRepository: NotificationRepository
    
    let itemService: ItemService
    let orderService: OrderService
    let followService: FollowService
    let notificationService: NotificationService
    
    @MainActor
    private init() {
        do {
            modelContainer = try ModelContainer(
                for: User.self, Item.self, Order.self, Follow.self, Notification.self
            )
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
        
        let context = modelContainer.mainContext
        userRepository = UserRepository(context: context)
        itemRepository = ItemRepository(context: context)
        orderRepository = OrderRepository(context: context)
        followRepository = FollowRepository(context: context)
        notificationRepository = NotificationRepository(context: context)
        
        itemService = ItemService(repository: itemRepository)
        orderService = OrderService(repository: orderRepository)
        followService = FollowService(repository: followRepository)
        notificationService = NotificationService(repository: notificationRepository)
        
        seedIfNeeded()
        restoreSession()
    }

    private func seedIfNeeded() {
        let existingUsers = (try? userRepository.fetchAll()) ?? []
        guard existingUsers.isEmpty else { return }
        
        let seller = User(name: "Toko Buah Segar", phone: "0812-0000-0001", location: "Jakarta", email: "tokobuah*****o@gmail.com")
        let buyer = User(name: "Budi", phone: "0812-0000-0002", location: "Bandung", email: "budi*****o@gmail.com")
        userRepository.insert(seller)
        userRepository.insert(buyer)
        
        do {
            try userRepository.save()
            
            let follow = try followService.sendRequest(from: buyer, to: seller)
            try notificationService.notifyFollowRequest(follow)
            
            try followService.accept(follow)
            try notificationService.markFollowRequestAccepted(follow)
            
            try itemService.createItem(
                seller: seller,
                title: "Apel Fuji",
                description: "Segar dari kebun",
                qualityGrade: .fresh,
                quantity: 10,
                pricePerUnit: 15_000,
                expiresAt: .now.addingTimeInterval(60 * 60 * 24 * 7)
            )
        } catch {
            print("Seed gagal: \(error)")
            return
        }
    }
    
    private func restoreSession() {
        let users = (try? userRepository.fetchAll()) ?? []
        guard let activeUserID = SessionManager.shared.activeUserID else {
            SessionManager.shared.setActiveUser(users.first!, role: .buyer)
            return
        }
    
        let resolved = users.first { $0.id.uuidString == activeUserID }
        SessionManager.shared.setActiveUser(resolved!, role: .buyer)
    }
}

