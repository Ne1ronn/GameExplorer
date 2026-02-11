import Foundation

struct Game: Identifiable, Codable {
    let id: Int
    let name: String
    let backgroundImage: String?
    let rating: Double
}
