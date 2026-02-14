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

                if (error as? URLError) != nil {
                    throw NetworkError.noInternet
                }

                throw NetworkError.unknown
            }

            return cached
        }
    }
    
    func searchGames(query: String, page: Int) async throws -> [Game] {
        do {
            let response: GameResponse = try await apiService.request(.search(query: query, page: page))
            return response.results
        } catch {
            if (error as? URLError) != nil {
                throw NetworkError.noInternet
            }
            throw NetworkError.unknown
        }
    }
    
    private func removeDuplicates(_ games: [Game]) -> [Game] {
        var seen = Set<Int>()
        return games.filter { seen.insert($0.id).inserted }
    }
}
