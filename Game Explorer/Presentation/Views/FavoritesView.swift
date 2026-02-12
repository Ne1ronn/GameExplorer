import SwiftUI
import Kingfisher

struct FavoritesView: View {

    @StateObject var viewModel = FavoritesViewModel()

    var body: some View {

        List(viewModel.favorites) { game in

            HStack {

                if let image = game.backgroundImage,
                   !image.isEmpty {

                    KFImage(URL(string: image))
                        .resizable()
                        .frame(width: 70, height: 50)
                        .cornerRadius(8)
                }

                Text(game.name)
            }
            .swipeActions {
                Button("Remove") {
                    viewModel.remove(game: game)
                }
                .tint(.red)
            }
        }
        .navigationTitle("Favorites")
    }
}
