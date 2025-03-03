//
//  MockAPIService.swift
//  V-ISTests
//
//  Created by Kirti on 3/2/25.
//

import XCTest
import Combine
@testable import V_IS


enum APIError: Error {
    case networkError
    case unknown
}

class MockAPIService: APIServiceProtocol {
    
    var mockMovieResponse: Result<[MovieTVItem], Error> = .success([])
    var mockTVResponse: Result<[MovieTVItem], Error> = .success([])
    var mockItemDetailsResponse: Result<ItemDetails, Error>?
    
    func fetchData<T: Decodable>(from url: URL, decodeAs type: T.Type) -> AnyPublisher<T, Error> {
          if url.absoluteString.contains("list-titles/movies"),
             let result = mockMovieResponse as? Result<T, Error> {
              return handleResult(result, as: type)
          } else if url.absoluteString.contains("list-titles/tv_series"),
                    let result = mockTVResponse as? Result<T, Error> {
              return handleResult(result, as: type)
          } else if url.absoluteString.contains("title/"),
                    let result = mockItemDetailsResponse as? Result<T, Error> {
              return handleResult(result, as: type)
          }
          return Fail(error: APIError.unknown).eraseToAnyPublisher()
      }
    
    private func handleResult<T: Decodable>(_ result: Result<T, Error>?, as type: T.Type) -> AnyPublisher<T, Error> {
        if let result = result {
            return result.publisher.eraseToAnyPublisher()
        } else {
            return Fail(error: APIError.unknown).eraseToAnyPublisher()
        }
    }
}



