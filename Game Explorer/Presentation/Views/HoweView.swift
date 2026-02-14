import SwiftUI
import Kingfisher

struct HomeView: View {

    @StateObject private var viewModel: HomeViewModel
    let container: AppContainer
    
    init(container: AppContainer) {

        _viewModel = StateObject(
            wrappedValue: HomeViewModel(
                repository: container.gameRepository
            )
        )

        self.container = container
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Games")
                .toolbar {

                    NavigationLink("Search") {
                        SearchView(
                            viewModel: SearchViewModel(
                                repository: container.gameRepository
                            )
                        )
                    }
                    
                    NavigationLink("Favorites") {
                        FavoritesView()
                    }

                    NavigationLink("Profile") {
                        ProfileView(
                            viewModel: ProfileViewModel(
                                firebase: container.firebaseService
                            )
                        )
                    }
                }
                .task {
                    await viewModel.loadGames()
                }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {

        case .idle:
            ProgressView()

        case .loading:
            ProgressView()

        case .empty:
            VStack {
                Text("No games found")
                Button("Retry") {
                    Task { await viewModel.loadGames() }
                }
            }

        case .error(let message):
            VStack {
                Text(message)
                Button("Retry") {
                    Task { await viewModel.loadGames() }
                }
            }

        case .success, .loadingNextPage:
            List(viewModel.games) { game in
                NavigationLink {
                    DetailsView(game: game)
                } label: {
                    HStack {
                        if let url = game.backgroundImage {
                            KFImage(URL(string: url))
                                .downsampling(size: CGSize(width: 80, height: 60))
                                .cancelOnDisappear(true)
                                .resizable()
                                .frame(width: 80, height: 60)
                                .cornerRadius(8)
                        }

                        Text(game.name)
                    }
                }
                .onAppear {
                    viewModel.loadNextPageIfNeeded(current: game)
                }
            }
        }
    }
}
