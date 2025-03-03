//
//  URLBuilder.swift
//  V-IS
//
//  Created by Kirti on 3/3/25.
//

import Foundation

struct URLBuilder {
    private let baseURL = AppConstants.baseURL
    
    func buildURL(for endpoint: APIEndpoint) -> URL? {
        var components = URLComponents(string: baseURL + endpoint.path)
        components?.queryItems = endpoint.queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components?.url
    }
}
