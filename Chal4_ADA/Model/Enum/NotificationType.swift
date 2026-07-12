//
//  NotificationType.swift
//  Chal4_ADA
//
//  Created by Danniel on 12/07/26.
//

nonisolated enum NotificationType : Codable{
    case incomingOrder(isCompleted: Bool)
    case followRequest(isAccepted: Bool)
}
