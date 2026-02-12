import Foundation
import Combine

@MainActor
final class CommentsViewModel: ObservableObject {

    @Published var comments: [Comment] = []
    @Published var inputText = ""

    private let service: CommentsService
    private let gameId: Int
    private let userId: String

    init(gameId: Int, userId: String, service: CommentsService = CommentsService()) {
        self.gameId = gameId
        self.userId = userId
        self.service = service

        observe()
    }

    private func observe() {
        service.observeComments(gameId: gameId) { [weak self] items in
            self?.comments = items
        }
    }

    func send() {

        guard !inputText.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }

        service.sendComment(
            gameId: gameId,
            text: inputText,
            userId: userId
        )

        inputText = ""
    }
}
