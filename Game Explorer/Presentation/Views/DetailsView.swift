import SwiftUI
import Kingfisher
import FirebaseAuth

struct DetailsView: View {

    let game: Game
    private let favoritesService = FavoritesService()
    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 16) {

                if let image = game.backgroundImage {
                    KFImage(URL(string: image))
                        .downsampling(size: CGSize(width: UIScreen.main.bounds.width,
                                                   height: 220))
                        .cancelOnDisappear(true)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 220)
                        .clipped()
                        .cornerRadius(12)
                }

                Text(game.name)
                    .font(.title)
                    .bold()

                Text("Rating: \(game.rating, specifier: "%.2f")")
                    .font(.headline)

                NavigationLink("Open Comments") {

                    CommentsView(
                        viewModel: CommentsViewModel(
                            gameId: game.id,
                            userId: Auth.auth().currentUser?.uid ?? "anon"
                        )
                    )
                }
                Button("Add to Favorites") {
                    guard let uid = Auth.auth().currentUser?.uid else { return }
                    favoritesService.add(game: game, userId: uid)
                }
                .padding(.top, 10)
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
