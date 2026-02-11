import Foundation

enum Endpoint {
    case games(page: Int)
    case search(query: String, page: Int)
    
    var url: URL {
        let apiKey = "YOUR_RAWG_API_KEY"
        
        switch self {
        case .games(let page):
            return URL(string:
                "https://api.rawg.io/api/games?key=\(apiKey)&page=\(page)"
            )!
            
        case .search(let query, let page):
            return URL(string:
                "https://api.rawg.io/api/games?key=\(apiKey)&search=\(query)&page=\(page)"
            )!
        }
    }
}
