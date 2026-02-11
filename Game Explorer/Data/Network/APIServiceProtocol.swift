import Foundation

protocol APIServiceProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}
