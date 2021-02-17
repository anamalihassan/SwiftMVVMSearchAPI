//
//  SearchVCViewModelTests.swift
//  TV ShowsTests
//
//  Created by Ali Hassan on 10/02/2021.
//

import XCTest
@testable import TV_Shows

class SearchVCViewModelTests: XCTestCase {
    var sut: SearchVCViewModel!
    var mockAPIService: MockAPIService!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mockAPIService = MockAPIService()
        sut = SearchVCViewModel(apiService: mockAPIService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func test_fetch_tv_shows() {
        sut.searchShows(search: "girl")
    
        // Assert
        XCTAssert(mockAPIService!.isFetchShowsInfoCalled)
    }
    
    func test_tv_shows_cells() {

        let stubShows = StubGenerator().stubTVShows()
        mockAPIService.showsResult = stubShows
        let expect = XCTestExpectation(description: "shows count")
        sut.reloadTVShowsTableView = { () in
            expect.fulfill()
        }
        
        sut.searchShows(search: "girl")
        
        // tvShowsCount is equal to the number of shows data
        XCTAssertEqual( sut.tvShowsCount, stubShows.count )
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 1.0)
        
    }

}

class MockAPIService: APIService {
    init() {
        super.init(searchType: SearchTypeEndPoint.searchShows.rawValue)
    }
    override func searchTVShows(search: String) {
        isFetchShowsInfoCalled = true
        showsResult = StubGenerator().stubTVShows()
        if let response = showsResult{
            self.delegate?.onFetchCompleted(with: response)
        }
    }
    
    
    var isFetchShowsInfoCalled = false
    
    var showsResult: [TVShowResult]?
    
}

class StubGenerator {
    func stubTVShows() -> [TVShowResult] {
        let path = Bundle.main.path(forResource: "shows", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let showsResult = try! decoder.decode(Array<TVShowResult>.self, from: data)
        return showsResult
    }
}

