import SwiftUI

struct ProfileView: View {

    @StateObject var viewModel: ProfileViewModel

    var body: some View {
        VStack(spacing: 20) {

            Text("Profile")
                .font(.largeTitle)
                .bold()

            Text("User ID:")
                .font(.headline)

            Text(viewModel.userId)
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Button("Logout") {
                viewModel.logout()
            }

            stateView
        }
        .padding()
    }

    @ViewBuilder
    private var stateView: some View {
        switch viewModel.state {
        case .error(let message):
            Text(message)
                .foregroundStyle(.red)

        default:
            EmptyView()
        }
    }
}
