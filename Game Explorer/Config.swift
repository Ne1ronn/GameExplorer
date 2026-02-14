import Foundation

enum Config {

    static var baseURL: String {
        Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
    }

    static var apiKey: String {
        Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? "KEY_MISSING"
    }

    
}
