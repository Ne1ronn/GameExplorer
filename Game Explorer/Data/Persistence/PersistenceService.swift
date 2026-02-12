import CoreData

protocol PersistenceServiceProtocol {
    func saveGames(_ games: [Game])
    func loadGames() -> [Game]
    func clearGames()
}

final class PersistenceService: PersistenceServiceProtocol {

    private let context = CoreDataStack.shared.container.viewContext

    func saveGames(_ games: [Game]) {

        clearGames()

        games.forEach {
            CachedGame.create(from: $0, context: context)
        }

        try? context.save()
    }

    func loadGames() -> [Game] {

        let request: NSFetchRequest<CachedGame> = CachedGame.fetchRequest()
        let result = (try? context.fetch(request)) ?? []

        return result.map { $0.toDomain() }
    }

    func clearGames() {

        let request: NSFetchRequest<NSFetchRequestResult> = CachedGame.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)

        try? context.execute(delete)
    }
}
