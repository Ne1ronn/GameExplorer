import Foundation
import Combine

@MainActor
final class SearchViewModel: ObservableObject {

    @Published var query = ""
    @Published var games: [Game] = []
    @Published var state: ViewState = .idle

    private let repository: GameRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()

    private var searchTask: Task<Void, Never>?
    private var currentPage = 1
    private var isLoading = false

    init(repository: GameRepositoryProtocol) {
        self.repository = repository
        bind()
    }

    private func bind() {
        $query
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] value in
                self?.startSearch(value)
            }
            .store(in: &cancellables)
    }

    private func startSearch(_ text: String) {

        searchTask?.cancel()

        guard !text.isEmpty else {
            games = []
            state = .idle
            return
        }

        searchTask = Task {
            state = .loading
            currentPage = 1

            do {
                let results = try await repository.searchGames(query: text, page: 1)

                if Task.isCancelled { return }

                games = results
                state = results.isEmpty ? .empty : .success
                currentPage += 1

            } catch {
                if Task.isCancelled { return }
                state = .error(error.localizedDescription)
            }
        }
    }

    func loadNextPageIfNeeded(current game: Game) {

        guard game.id == games.last?.id else { return }
        guard !isLoading else { return }

        isLoading = true

        Task {
            do {
                let next = try await repository.searchGames(
                    query: query,
                    page: currentPage
                )

                if Task.isCancelled { return }

                games.append(contentsOf: next)
                currentPage += 1

            } catch { }

            isLoading = false
        }
    }
}
