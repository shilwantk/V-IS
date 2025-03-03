//
//  ItemDetails.swift
//  V-IS
//
//  Created by Kirti on 2/28/25.
//

import Foundation

struct ItemDetails: Decodable {
    let id: Int
    let title: String
    let releaseDate: String
    let plotOverview: String
    let poster : String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case plotOverview = "plot_overview"
        case releaseDate = "release_date"
        case poster
    }
}
