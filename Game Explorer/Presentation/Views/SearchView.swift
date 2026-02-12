import SwiftUI
import Kingfisher

struct SearchView: View {

    @StateObject var viewModel: SearchViewModel

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Search")
                .searchable(text: $viewModel.query)
        }
    }

    @ViewBuilder
    private var content: some View {

        switch viewModel.state {

        case .loading:
            ProgressView()

        case .empty:
            Text("No results")

        case .error(let message):
            VStack {
                Text(message)
                Button("Retry") {
                    viewModel.query = viewModel.query
                }
            }

        default:
            List(viewModel.games) { game in
                NavigationLink {
                    DetailsView(game: game)
                } label: {
                    Text(game.name)
                }
                .onAppear {
                    viewModel.loadNextPageIfNeeded(current: game)
                }
            }
        }
    }
}
