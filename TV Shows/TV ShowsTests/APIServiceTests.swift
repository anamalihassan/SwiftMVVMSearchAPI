//
//  APIServiceTests.swift
//  TV ShowsTests
//
//  Created by Ali Hassan on 10/02/2021.
//

import XCTest
@testable import TV_Shows

class APIServiceTests: XCTestCase, APIServiceDelegate {
    
    var apiService: APIService?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class APIService
        super.setUp()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        apiService = nil
        super.tearDown()
    }
    
    private var onFetchCompletedExpectation: XCTestExpectation!
    private var onFetchFailedExpectation: XCTestExpectation!
    private var tvShowsResult: [TVShowResult]!
    private var errorReason: String!
    
    func test_fetch_shows_success() {

        // Given A apiservice
        apiService = APIService(searchType: SearchTypeEndPoint.searchShows.rawValue)
        apiService?.delegate = self

        onFetchCompletedExpectation = expectation(description: "onFetchCompletedExpectation")
        apiService?.searchTVShows(search: "girl")
        
        waitForExpectations(timeout: 100)
        XCTAssertNotNil(self.tvShowsResult)
        XCTAssertNil(self.errorReason)
    }
    
    func test_fetch_shows_failure() {

        // Given A apiservice
        apiService = APIService(searchType: "invalidURL")
        apiService?.delegate = self

        onFetchFailedExpectation = expectation(description: "onFetchFailed")
        apiService?.searchTVShows(search: "girl")
        
        waitForExpectations(timeout: 100)
        XCTAssertNil(self.tvShowsResult)
        XCTAssertNotNil(self.errorReason)
    }
    
    func onFetchCompleted(with tvShowsResult: [TVShowResult]) {
        self.tvShowsResult = tvShowsResult
        onFetchCompletedExpectation.fulfill()
    }
    
    
    func onFetchFailed(with reason: String) {
        self.errorReason = reason
        onFetchFailedExpectation.fulfill()
    }

}

