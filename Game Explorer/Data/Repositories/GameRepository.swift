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
        let response: GameResponse = try await apiService.request(.games(page: page))
        return response.results
    }
    
    func searchGames(query: String, page: Int) async throws -> [Game] {
        let response: GameResponse = try await apiService.request(.search(query: query, page: page))
        return response.results
    }
}
