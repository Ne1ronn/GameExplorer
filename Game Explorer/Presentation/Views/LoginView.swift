import SwiftUI

struct LoginView: View {

    @StateObject var viewModel: LoginViewModel

    var body: some View {
        VStack(spacing: 16) {

            Text("Sign In")
                .font(.largeTitle)
                .bold()

            TextField("Email", text: $viewModel.email)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)

            Button("Login") {
                viewModel.signIn()
            }
            .disabled(!viewModel.isValid)

            stateView
        }
        .padding()
    }

    @ViewBuilder
    private var stateView: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()

        case .error(let message):
            Text(message)
                .foregroundStyle(.red)

        default:
            EmptyView()
        }
    }
}
