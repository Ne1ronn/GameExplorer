import Foundation
import FirebaseAuth
import Combine

@MainActor
final class FavoritesViewModel: ObservableObject {

    @Published var favorites: [Game] = []

    private let service = FavoritesService()

    init() {
        observe()
    }

    private func observe() {

        guard let uid = Auth.auth().currentUser?.uid else { return }

        service.observe(userId: uid) { [weak self] games in
            self?.favorites = games
        }
    }

    func remove(game: Game) {

        guard let uid = Auth.auth().currentUser?.uid else { return }

        service.remove(gameId: game.id, userId: uid)
    }
}
