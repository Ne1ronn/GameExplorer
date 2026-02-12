import Foundation
import Combine

@MainActor
final class ProfileViewModel: ObservableObject {

    @Published var state: ViewState = .idle

    private let firebase: FirebaseServiceProtocol

    init(firebase: FirebaseServiceProtocol) {
        self.firebase = firebase
    }

    var userId: String {
        firebase.userId ?? "Unknown"
    }

    func logout() {
        do {
            try firebase.signOut()
            state = .success
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
