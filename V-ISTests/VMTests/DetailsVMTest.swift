//
//  DetailsVMTest.swift
//  V-ISTests
//
//  Created by Kirti on 3/2/25.
//

import XCTest
import Combine
@testable import V_IS

class DetailsViewModelTests: XCTestCase {
    
    var viewModel: DetailsViewModel!
    var mockAPIService: MockAPIService!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        viewModel = DetailsViewModel(apiService: mockAPIService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testFetchDetails_Success() {
        
        let mockItem = ItemDetails(id: 1, title: "Mock Movie", releaseDate: "2025-01-01", plotOverview: "A test movie.", poster: "mock_url")
        mockAPIService.mockItemDetailsResponse = .success(mockItem)
        
        let expectation = XCTestExpectation(description: "Data fetched successfully")
        viewModel.fetchDetails(itemId: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewModel.item)
            XCTAssertEqual(self.viewModel.item?.title, "Mock Movie")
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func testFetchDetails_Failure() {
        
        mockAPIService.mockItemDetailsResponse = .failure(APIError.networkError)
        
        let expectation = XCTestExpectation(description: "Error is handled properly")
        viewModel.fetchDetails(itemId: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNil(self.viewModel.item)
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNotNil(self.viewModel.errorMessage)
            XCTAssertTrue(self.viewModel.errorMessage!.contains("Failed to load details"))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func testFetchDetails_InvalidURL() {

        let expectation = XCTestExpectation(description: "Invalid URL should set error message")
        viewModel.fetchDetails(itemId: -1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNil(self.viewModel.item)
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(self.viewModel.errorMessage, "Invalid URL")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func testFetchDetails_LoadingState() {

        mockAPIService.mockItemDetailsResponse = .success(ItemDetails(id: 1, title: "Mock", releaseDate: "", plotOverview: "", poster: ""))

        let expectation = XCTestExpectation(description: "Loading state transitions correctly")
        viewModel.fetchDetails(itemId: 1)
        XCTAssertTrue(viewModel.isLoading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.isLoading) // Should be false after fetch
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
}
