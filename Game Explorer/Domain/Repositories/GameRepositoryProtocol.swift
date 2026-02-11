import Foundation

protocol GameRepositoryProtocol {
    func fetchGames(page: Int) async throws -> [Game]
    func searchGames(query: String, page: Int) async throws -> [Game]
}
