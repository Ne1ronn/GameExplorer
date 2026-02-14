final class MockRepository: GameRepositoryProtocol {

    func fetchGames(page: Int) async throws -> [Game] {
        [
            Game(id: 1, name: "Test", backgroundImage: nil, rating: 1)
        ]
    }

    func searchGames(query: String, page: Int) async throws -> [Game] {
        []
    }
}
