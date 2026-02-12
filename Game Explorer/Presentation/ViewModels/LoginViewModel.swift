import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""
    @Published var state: ViewState = .idle

    private let firebase: FirebaseServiceProtocol

    init(firebase: FirebaseServiceProtocol) {
        self.firebase = firebase
    }

    var isValid: Bool {
        email.contains("@") && password.count >= 6
    }

    func signIn() {

        guard isValid else {
            state = .error("Enter valid credentials")
            return
        }

        Task {
            state = .loading

            do {
                try await firebase.signIn(email: email, password: password)
                state = .success
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}
