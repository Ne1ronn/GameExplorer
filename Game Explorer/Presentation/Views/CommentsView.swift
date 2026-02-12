import SwiftUI

struct CommentsView: View {

    @StateObject var viewModel: CommentsViewModel

    var body: some View {

        VStack {

            List(viewModel.comments) { comment in
                VStack(alignment: .leading) {
                    Text(comment.text)
                    Text(comment.userId)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            HStack {

                TextField("Comment...", text: $viewModel.inputText)
                    .textFieldStyle(.roundedBorder)

                Button("Send") {
                    viewModel.send()
                }
            }
            .padding()
        }
        .navigationTitle("Comments")
    }
    
}
