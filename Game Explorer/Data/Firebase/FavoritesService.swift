import FirebaseDatabase

final class FavoritesService {

    private let db = Database.database().reference()

    func add(game: Game, userId: String) {
        db.child("favorites/\(userId)/\(game.id)")
            .setValue([
                "name": game.name,
                "rating": game.rating,
                "image": game.backgroundImage ?? ""
            ])
    }

    func remove(gameId: Int, userId: String) {
        db.child("favorites/\(userId)/\(gameId)").removeValue()
    }

    func observe(userId: String, handler: @escaping ([Game]) -> Void) {

        db.child("favorites/\(userId)")
            .observe(.value) { snapshot in

                var items: [Game] = []

                for child in snapshot.children {

                    guard let snap = child as? DataSnapshot,
                          let value = snap.value as? [String: Any],
                          let name = value["name"] as? String,
                          let rating = value["rating"] as? Double
                    else { continue }

                    let image = value["image"] as? String

                    items.append(
                        Game(
                            id: Int(snap.key) ?? 0,
                            name: name,
                            backgroundImage: image,
                            rating: rating
                        )
                    )
                }

                handler(items)
            }
    }
}
