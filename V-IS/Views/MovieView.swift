//
//  MovieView.swift
//  V-IS
//
//  Created by Kirti on 2/28/25.
//

import SwiftUI

struct MovieTVRowView: View {
    let item: MovieTVItem
    
    var body: some View {
        HStack {
            Image(systemName: "movieclapper")
                .resizable()
                .frame(width: 35, height: 35)
            VStack(alignment: .leading) {
                Text(item.title).font(.headline)
                Text(item.title).font(.subheadline).foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
    }
}

struct MovieTVRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovieTVRowView(item: MovieTVItem(id: 1, title: "Example Movie"))
            .previewLayout(.sizeThatFits)
    }
}
