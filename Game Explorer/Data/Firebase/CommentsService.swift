import FirebaseDatabase

final class CommentsService {

    private let db = Database.database().reference()

    func observeComments(gameId: Int, handler: @escaping ([Comment]) -> Void) {

        db.child("comments/\(gameId)")
            .observe(.value) { snapshot in

                var items: [Comment] = []

                for child in snapshot.children {

                    guard let snap = child as? DataSnapshot,
                          let value = snap.value as? [String: Any],
                          let text = value["text"] as? String,
                          let userId = value["userId"] as? String
                    else { continue }

                    items.append(
                        Comment(
                            id: snap.key,
                            text: text,
                            userId: userId
                        )
                    )
                }

                handler(items)
            }
    }

    func sendComment(gameId: Int, text: String, userId: String) {

        let ref = db.child("comments/\(gameId)").childByAutoId()

        ref.setValue([
            "text": text,
            "userId": userId
        ])
    }
}
