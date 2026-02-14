enum ViewState: Equatable {
    case idle
    case loading
    case success
    case empty
    case error(String)
    case loadingNextPage
}
