import SwiftUI
import Kingfisher

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Games")
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
                HStack {
                    if let url = game.backgroundImage {
                        KFImage(URL(string: url))
                            .resizable()
                            .frame(width: 80, height: 60)
                            .cornerRadius(8)
                    }
                    
                    Text(game.name)
                }
                .onAppear {
                    if game.id == viewModel.games.last?.id {
                        Task {
                            await viewModel.loadGames()
                        }
                    }
                }
            }
        }
    }
}


