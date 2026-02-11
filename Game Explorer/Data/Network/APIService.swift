import Foundation

final class APIService: APIServiceProtocol {
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        
        let (data, response) = try await URLSession.shared.data(from: endpoint.url)
        
        guard let http = response as? HTTPURLResponse,
              200..<300 ~= http.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
