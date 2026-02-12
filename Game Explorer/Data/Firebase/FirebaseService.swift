import FirebaseAuth

protocol FirebaseServiceProtocol {
    var userId: String? { get }
    func signIn(email: String, password: String) async throws
    func signOut() throws
}

final class FirebaseService: FirebaseServiceProtocol {

    var userId: String? {
        Auth.auth().currentUser?.uid
    }

    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }
}
