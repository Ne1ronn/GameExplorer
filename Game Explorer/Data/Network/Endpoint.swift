import Foundation

enum Endpoint {
    case games(page: Int)
    case search(query: String, page: Int)

    var url: URL {
        var components = URLComponents(string: "https://api.rawg.io/api/games")!

        switch self {

        case .games(let page):
            components.queryItems = [
                URLQueryItem(name: "key", value: Config.apiKey),
                URLQueryItem(name: "page", value: String(page))
            ]

        case .search(let query, let page):
            components.queryItems = [
                URLQueryItem(name: "key", value: Config.apiKey),
                URLQueryItem(name: "search", value: query),
                URLQueryItem(name: "page", value: String(page))
            ]
        }

        return components.url!
    }
}
