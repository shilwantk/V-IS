//
//  Endpoints.swift
//  V-IS
//
//  Created by Kirti on 3/3/25.
//
import Foundation

enum APIEndpoint {
    
    case movieList
    case tvShowList
    case details(Int)

    var path: String {
        switch self {
        case .movieList: return "/list-titles/"
        case .tvShowList: return "/list-titles/"
        case .details(let itemId): return "/title/\(itemId)/details/"
        }
    }

    var queryParams: [String: String] {
        switch self {
        case .movieList:
            return ["apiKey": AppConstants.apiKey, "types": "movie"]
        case .tvShowList:
            return ["apiKey": AppConstants.apiKey, "types": "tv_series"]
        case .details:
            return ["apiKey": AppConstants.apiKey]
        }
    }
}

