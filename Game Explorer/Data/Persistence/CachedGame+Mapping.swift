import CoreData

extension CachedGame {

    static func create(from game: Game, context: NSManagedObjectContext) {
        let entity = CachedGame(context: context)

        entity.id = Int64(game.id)
        entity.name = game.name
        entity.rating = game.rating
        entity.image = game.backgroundImage
    }

    func toDomain() -> Game {
        Game(
            id: Int(id),
            name: name ?? "",
            backgroundImage: image,
            rating: rating
        )
    }
}
