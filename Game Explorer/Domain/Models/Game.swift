import Foundation

struct Game: Identifiable, Codable {

    let id: Int
    let name: String
    let backgroundImage: String?
    let rating: Double

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backgroundImage = "background_image"
        case rating
    }
}
