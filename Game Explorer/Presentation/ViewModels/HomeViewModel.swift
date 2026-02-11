import Foundation

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
        
        state = .loading
        isLoading = true
        
        do {
            let newGames = try await repository.fetchGames(page: currentPage)
            games.append(contentsOf: newGames)
            state = games.isEmpty ? .empty : .success
            currentPage += 1
        } catch {
            state = .error(error.localizedDescription)
        }
        
        isLoading = false
    }
}
