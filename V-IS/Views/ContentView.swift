//
//  ContentView.swift
//  V-IS
//
//  Created by Kirti on 2/28/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MovieTVViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                CategoryPickerView(selectedCategory: $viewModel.selectedCategory)
                
                if viewModel.isLoading {
                    MovieTVRowView(item: MovieTVItem(id: 0, title: "Loading..."))
                           .redacted(reason: .placeholder)
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.red)
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                        Button("Retry") {
                            viewModel.fetchData()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                } else {
                    ScrollView {
                        LazyVStack {
                            if viewModel.selectedCategory == .movies{
                                ForEach(viewModel.movieItems) { item in
                                    NavigationLink(destination: DetailsView(itemId: item.id)) {
                                        MovieTVRowView(item: item)
                                    }
                                }
                            } else {
                                ForEach(viewModel.tvItems) { item in
                                    NavigationLink(destination: DetailsView(itemId: item.id)) {
                                        MovieTVRowView(item: item)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Discover")
            .onAppear { viewModel.fetchData() }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
