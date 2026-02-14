import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    
    @Published var games: [Game] = []
    @Published var state: ViewState = .idle
    
    private let repository: GameRepositoryProtocol
    
    private var currentPage = 1
    private var isLoading = false
    
    init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadGames() async {
        guard !isLoading else { return }

        if games.isEmpty {
            state = .loading
        } else {
            state = .loadingNextPage
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let newGames = try await repository.fetchGames(page: currentPage)

            if newGames.isEmpty {
                state = games.isEmpty ? .empty : .success
                return
            }

            games.append(contentsOf: newGames)
            state = .success
            currentPage += 1

        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    func loadNextPageIfNeeded(current game: Game) {

        guard !isLoading else { return }

        guard let index = games.firstIndex(where: { $0.id == game.id }) else { return }

        if index >= games.count - 5 {
            Task { await loadGames() }
        }
    }
}
