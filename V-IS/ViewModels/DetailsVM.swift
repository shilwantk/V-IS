//
//  DetailsVM.swift
//  V-IS
//
//  Created by Kirti on 2/28/25.
//

import SwiftUI
import Combine

class DetailsViewModel: ObservableObject {
    
    @Published var item: ItemDetails?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchDetails(itemId: Int) {
        isLoading = true
        errorMessage = nil
        
        let detailEndpoint = APIEndpoint.details(itemId)
        
        guard let detailsURL = URLBuilder().buildURL(for: detailEndpoint) else {
            self.errorMessage = "Invalid URL"
            self.isLoading = false
            return
        }
        
        apiService.fetchData(from: detailsURL, decodeAs: ItemDetails.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = "Failed to load details: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] item in
                self?.item = item
            })
            .store(in: &cancellables)
    }
}

