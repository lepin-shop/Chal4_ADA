import Foundation

@Observable
final class NotificationScreenViewModel {
    private let followRepository: FollowRepository
    private let followService: FollowService
    private let notificationService: NotificationService

    var errorMessage: String?

    init(
        followRepository: FollowRepository = AppContainer.shared.followRepository,
        followService: FollowService = AppContainer.shared.followService,
        notificationService: NotificationService = AppContainer.shared.notificationService
    ) {
        self.followRepository = followRepository
        self.followService = followService
        self.notificationService = notificationService
    }

    func acceptFollowRequest(from notification: Notification) {
        guard let relatedID = notification.relatedID else { return }
        do {
            guard let follow = try followRepository.fetch(byId: relatedID) else { return }
            try followService.accept(follow)
            try notificationService.markFollowRequestAccepted(follow)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
