//
//  ItemList.swift
//  V-IS
//
//  Created by Kirti on 2/28/25.
//

import Foundation

struct DataList: Decodable {
    let titles: [MovieTVItem]
}

struct MovieTVItem: Decodable, Identifiable {
    let id: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
    }
}
