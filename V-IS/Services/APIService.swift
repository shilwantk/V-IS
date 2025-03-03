import Combine
import Foundation

// MARK: - API Errors
enum APIError: Error, LocalizedError {
    case invalidResponse(Int)
    case networkError(String)
    case parsingError(Error)
    case unknownError

    var errorDescription: String? {
        switch self {
        case .invalidResponse(let statusCode): return "Invalid response: HTTP \(statusCode)"
        case .networkError(let message): return "Network error: \(message)"
        case .parsingError(let error): return "Failed to decode response: \(error.localizedDescription)"
        case .unknownError: return "An unknown error occurred."
        }
    }
}

protocol APIServiceProtocol {
    func fetchData<T: Decodable>(from url: URL, decodeAs type: T.Type) -> AnyPublisher<T, Error>
}

class APIService: APIServiceProtocol {
    func fetchData<T: Decodable>(from url: URL, decodeAs type: T.Type) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
