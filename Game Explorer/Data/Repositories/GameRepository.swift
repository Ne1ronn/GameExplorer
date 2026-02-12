import Foundation

final class GameRepository: GameRepositoryProtocol {
    
    private let apiService: APIServiceProtocol
    private let persistenceService: PersistenceServiceProtocol
    
    init(apiService: APIServiceProtocol,
         persistenceService: PersistenceServiceProtocol) {
        self.apiService = apiService
        self.persistenceService = persistenceService
    }
    
    func fetchGames(page: Int) async throws -> [Game] {

        do {
            let response: GameResponse = try await apiService.request(.games(page: page))

            let unique = removeDuplicates(response.results)

            persistenceService.saveGames(unique)

            return unique

        } catch {

            let cached = persistenceService.loadGames()

            if cached.isEmpty {
                throw error
            }

            return cached
        }
    }
    
    func searchGames(query: String, page: Int) async throws -> [Game] {
        let response: GameResponse = try await apiService.request(.search(query: query, page: page))
        return response.results
    }
    
    private func removeDuplicates(_ games: [Game]) -> [Game] {
        var seen = Set<Int>()
        return games.filter { seen.insert($0.id).inserted }
    }
}
