//
//  ListVMTest.swift
//  V-ISTests
//
//  Created by Kirti on 3/3/25.
//

import XCTest
import Combine
@testable import V_IS

final class ListVMTest: XCTestCase {
    
    var viewModel: MovieTVViewModel!
    var mockAPIService: MockAPIService!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockAPIService = MockAPIService()
        viewModel = MovieTVViewModel(apiService: mockAPIService)
        
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockAPIService = nil
        cancellables.removeAll()
        try super.tearDownWithError()
    }
    
    func testFetchDataSuccess() {
        
        let mockMovies = [MovieTVItem(id: 1, title: "Movie 1"), MovieTVItem(id: 2, title: "Movie 2")]
        let mockTVShows = [MovieTVItem(id: 3, title: "TV Show 1"), MovieTVItem(id: 4, title: "TV Show 2")]
        mockAPIService.mockMovieResponse = .success(mockMovies)
        mockAPIService.mockTVResponse = .success(mockTVShows)
        let expectation = XCTestExpectation(description: "Fetch movie and TV data successfully")
        viewModel.$movieItems
            .dropFirst()
            .sink { movies in
                XCTAssertEqual(movies.count, 2)
                XCTAssertEqual(movies.first?.title, "Movie 1")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.fetchData()
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFetchDataFailure() {
        mockAPIService.mockMovieResponse = .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Movie API Failed"]))
        mockAPIService.mockTVResponse = .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "TV API Failed"]))
        let expectation = XCTestExpectation(description: "Handle API failure")
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage)
                XCTAssertTrue(((errorMessage?.contains("Failed to load data")) != nil))
                expectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.fetchData()
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testCategorySelectionUpdates() {
        XCTAssertEqual(viewModel.selectedCategory, .movies)
        let expectation = XCTestExpectation(description: "Category change triggers UI update")
        viewModel.$selectedCategory
            .dropFirst()
            .sink { category in
                XCTAssertEqual(category, .tvShows)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.selectedCategory = .tvShows
        wait(for: [expectation], timeout: 1.0)
    }
}
