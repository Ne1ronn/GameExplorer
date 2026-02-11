import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var container: AppContainer
    
    var body: some View {
        HomeView(
            viewModel: HomeViewModel(
                repository: container.gameRepository
            )
        )
    }
}
H
