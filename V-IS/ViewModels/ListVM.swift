//
//  DataVM.swift
//  V-IS
//
//  Created by Kirti on 2/28/25.
//

import SwiftUI
import Combine

class MovieTVViewModel: ObservableObject {
    
    @Published var movieItems: [MovieTVItem] = []
    @Published var tvItems: [MovieTVItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedCategory: Category = .movies {
        didSet { updateDisplayedItems() }
    }
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchData() {
        guard movieItems.isEmpty || tvItems.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        
        guard let movieURL = URLBuilder().buildURL(for: APIEndpoint.movieList) else {
            self.errorMessage = "Invalid URL"
            self.isLoading = false
            return
        }
        guard let tvURL = URLBuilder().buildURL(for: APIEndpoint.tvShowList) else {
            self.errorMessage = "Invalid URL"
            self.isLoading = false
            return }
        
        let moviesPublisher = fetchMovies(from: movieURL)
        let tvShowsPublisher = fetchMovies(from: tvURL)
        
        Publishers.Zip(moviesPublisher, tvShowsPublisher)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = "Failed to load data: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] movies, tvShows in
                self?.movieItems = movies
                self?.tvItems = tvShows
            })
            .store(in: &cancellables)
    }
    
    
    private func fetchMovies(from url: URL) -> AnyPublisher<[MovieTVItem], Error> {
        return apiService.fetchData(from: url, decodeAs: DataList.self)
            .map { $0.titles }
            .eraseToAnyPublisher()
    }
    
    private func updateDisplayedItems() {
        objectWillChange.send()
    }
}
