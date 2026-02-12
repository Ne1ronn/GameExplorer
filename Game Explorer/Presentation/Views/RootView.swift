import SwiftUI
import Foundation
import Combine

struct RootView: View {

    @EnvironmentObject var container: AppContainer

    var body: some View {

        if container.firebaseService.userId != nil {

            HomeView(
                viewModel: HomeViewModel(
                    repository: container.gameRepository
                ),
                container: container
            )

        } else {

            LoginView(
                viewModel: LoginViewModel(
                    firebase: container.firebaseService
                )
            )
        }
    }
}
