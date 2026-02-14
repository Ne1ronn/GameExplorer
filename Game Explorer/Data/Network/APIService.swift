import Foundation

final class APIService: APIServiceProtocol {
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {

        let (data, response) = try await URLSession.shared.data(from: endpoint.url)

        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }

        guard 200..<300 ~= http.statusCode else {
            throw NetworkError.serverError(
                String(data: data, encoding: .utf8) ?? "Bad status code: \(http.statusCode)"
            )
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.serverError(
                String(data: data, encoding: .utf8) ?? "Decoding failed"
            )
        }
    }
}
