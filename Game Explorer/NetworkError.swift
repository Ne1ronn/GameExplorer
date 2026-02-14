import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case noInternet
    case serverError(String)
    case decodingError
    case unknown

    var errorDescription: String? {
        switch self {

        case .invalidURL:
            return "Invalid URL"

        case .noInternet:
            return "No internet connection"

        case .serverError(let message):
            return message

        case .decodingError:
            return "Decoding error"

        case .unknown:
            return "Unknown error"
        }
    }
}
