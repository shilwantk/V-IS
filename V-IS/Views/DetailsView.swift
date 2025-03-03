//
//  DetailsView.swift
//  V-IS
//
//  Created by Kirti on 2/28/25.
//

import SwiftUI

struct DetailsView: View {
    let itemId: Int
    @StateObject private var viewModel = DetailsViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                if viewModel.isLoading {
                    ProgressView().scaleEffect(1.5)
                } else if let item = viewModel.item {
                    AsyncImage(url: URL(string:item.poster)) { image in
                        image.resizable()
                    } placeholder: {
                        Rectangle().fill(Color.gray.opacity(0.3))
                    }
                    .frame(height: 300)
                    .cornerRadius(12)
                    
                    Text(item.title).font(.title).bold()
                    Text(item.releaseDate).font(.subheadline).foregroundColor(.gray)
                    Text(item.plotOverview).padding()
                    Spacer()
                } else if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                }
            }
            .padding()
            .navigationTitle("Details")
            .onAppear { viewModel.fetchDetails(itemId: itemId) }
        }
    }
}


