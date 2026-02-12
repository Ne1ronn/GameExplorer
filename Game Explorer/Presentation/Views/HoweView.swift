import SwiftUI
import Kingfisher

struct HomeView: View {

    @StateObject var viewModel: HomeViewModel
    let container: AppContainer

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
        case .loading:
            ProgressView()
            
        case .error(let message):
            VStack {
                Text(message)
                Button("Retry") {
                    Task { await viewModel.loadGames() }
                }
            }
            
        default:
            List(viewModel.games) { game in

                NavigationLink {
                    DetailsView(game: game)
                } label: {

                    HStack {

                        if let url = game.backgroundImage {
                            KFImage(URL(string: url))
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


